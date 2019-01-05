module Admins
  class CategoriesController < BaseController
    before_action :find_category, only: %i(show edit update destroy add_or_minus_morderator ban_or_unban_authors)
    before_action :all_categories, only: %i(index new edit)
    before_action :find_user, only: %i(add_or_minus_morderator ban_or_unban_authors)

    def new
      @category = Category.new
    end

    def index
      respond_to do |format|
        format.html
        format.json { render json: CategoriesDatatable.new(view_context) }
      end
    end

    def show
      @morderators = search category.morderators
    end

    def edit
      all_morderators = category.morderators
      @morderators = search all_morderators
      @users = search User.where.not(id: all_morderators)
      
      all_banning_authors = Author.joins(:categories).where(categories: {id: category})
      @banning_authors = search all_banning_authors
      @authors = search Author.where.not(id: all_banning_authors)

      @action = params[:target]

      respond_to do |format|
        format.html
        format.js
      end
    end

    def create
      if current_user.categories.new(category_params).save
        message = "Tạo chuyên mục thành công"
        icon = "success"
        path = admins_categories_path
      else
        message = "Tạo chuyên mục thất bại"
        icon = "warning"
        path = "#"
      end

      @notification = notification(message, icon, path=path)

      respond_to do |format|
        format.js
      end
    end

    def update
      if category.update_attributes category_params
        redirect_to admins_categories_path
      else
        redirect_to admins_categories_path
      end
    end
  
    def destroy
      if category.posts.present?
        category.update(status: :unpublish)
        message = "Không thể xóa chuyên mục có bài viết!!! Đã chuyển trạng thái chuyên mục thành không công khai."
        icon = "warning"
      else
        category.destroy
        message = "Xóa chuyên mục thành công"
        icon = "success"
      end
      
      @notification = notification(message, icon, path=path)
      @class = "delete-" << params[:id]

      respond_to do |format|
        format.js
      end
    end

    def add_or_minus_morderator
      user.type = Morderator.name if user.type == Author.name
      ActiveRecord::Base.transaction do
        user.save(validate: false)
        find_user
        category_management = user.category_managements.where(category: category)
        begin
          if (turn_user = category_management.present?)
            category_management.destroy_all
            user.update(type: Author.name) unless user.category_managements.present?
          else
            user.category_managements.create category: category
          end
          status = 200
        rescue Exception
          message = "Đã có lỗi xảy ra!!!"
          icon = "warning"
          status = 500
        end
        @notification = notification(message, icon)

        respond_to do |format|
          if status == 200
            if turn_user
              format.html { render partial: "admins/users/user_item", locals: {user: user, add_morderator: true, source: category, action: :add} }
            else
              format.html { render partial: "admins/users/morderator_item", locals: {user: user, source: category} }
            end
          else
            format.json { render json: @notification }
          end
        end
      end
    end

    def ban_or_unban_authors
      ActiveRecord::Base.transaction do
        category_banning = user.category_bannings.where(category: category)
        begin
          if (unban_user = category_banning.present?)
            category_banning.destroy_all
          else
            user.category_bannings.create category: category
          end
          status = 200
        rescue Exception
          message = "Đã có lỗi xảy ra!!!"
          icon = "warning"
          status = 500
        end
        @notification = notification(message, icon)

        respond_to do |format|
          if status == 200
            if unban_user
              format.html { render partial: "admins/users/user_item", locals: {user: user, add_morderator: true, source: category, action: :ban} }
            else
              format.html { render partial: "admins/users/banning_authors", locals: {user: user, source: category, action: :unban} }
            end
          else
            format.json { render json: @notification }
          end
        end
      end
    end

    private

    attr_reader :category, :morderators, :categories, :user 

    def category_params
      category = params.require(:category).permit Category::CATEGORY_ATTRS
      category["status"] = category["status"].to_i
      category
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if category.present?
      redirect_to admins_categories_path
    end

    def all_categories
      @categories = Category.all
    end

    def find_user
      @user = User.find_by id: params[:user_id]
      return if user.present?
      redirect_to root_path
    end
  end
end
