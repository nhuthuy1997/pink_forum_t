module Admins
  class CategoriesController < BaseController
    before_action :find_category, only: %i(show)
    before_action :all_categories, only: %i(index new)

    def new
      @category = Category.new
    end

    def index; end

    def show; end

    def create
      byebug
      current_user.categories.create category_params
      redirect_to admins_root_path
    end

    def update
      if @category.update_attributes category_params
        flash[:success] = t ".success"
        redirect_to categories_path
      else
        flash[:danger] = t "danger"
        redirect_to root_path
      end
    end
  
    def destroy
      @category.update(status: :unpublish)
      redirect_back admins_root_path
    end

    private

    attr_reader :category

    def category_params
      category = params.require(:category).permit Category::CATEGORY_ATTRS
      category["status"] = category["status"].to_i
      category
    end

    def find_category
      @category = Category.find_by id: params[:id]
      return if @category
      redirect_to root_path
    end

    def all_categories
      @categories = Category.all
    end
  end
end
