module Admins
  class TopicsController < BaseController
    before_action :all_topic, only: %i(index show edit)
    before_action :categories, only: %i(new show edit)
    before_action :find_topic, only: %i(show edit update destroy ban_or_unban_authors)
    before_action :find_user, only: %i(ban_or_unban_authors)

    def index
      respond_to do |format|
        format.html
        format.json { render json: TopicsDatatable.new(view_context) }
      end
    end

    def show
      @posts = topic.posts
    end

    def new; end

    def create
      if current_user.topics.new(topic_params).save
        message = "Tạo chủ đề thành công"
        icon = "success"
        path = admins_topics_path
      else
        message = "Tạo chủ đề thất bại"
        icon = "warning"
        path = "#"
      end

      @notification = notification(message, icon, path=path)

      respond_to do |format|
        format.js
      end
    end

    def edit
      all_banning_authors = Author.joins(:topics).where(topics: {id: topic})
      @banning_authors = search all_banning_authors
      @authors = search Author.where.not(id: all_banning_authors)

      @action = params[:target]

      respond_to do |format|
        format.html
        format.js
      end
    end

    def update
    end

    def destroy
      if topic.posts.present?
        topic.update(status: :unpublish)
        message = "Không thể xóa chuyên mục có bài viết!!! Đã chuyển trạng thái chuyên mục thành không công khai."
        icon = "warning"
      else
        topic.destroy
        message = "Xóa chuyên mục thành công"
        icon = "success"
      end
      
      @notification = notification(message, icon, path=path)
      @class = "delete-" << params[:id]

      respond_to do |format|
        format.js
      end
    end

    def ban_or_unban_authors
      ActiveRecord::Base.transaction do
        topic_banning = user.topic_bannings.where(topic: topic)

        begin
          if (unban_user = topic_banning.present?)
            topic_banning.destroy_all
          else
            user.topic_bannings.create topic: topic
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
              format.html { render partial: "admins/users/user_item", locals: {user: user, add_morderator: true, source: topic, action: :topic_ban} }
            else
              format.html { render partial: "admins/users/banning_authors", locals: {user: user, source: topic, action: :topic_unban} }
            end
          else
            format.json { render json: @notification }
          end
        end
      end
    end

    private

    attr_reader :topics, :topic, :user

    def topic_params
      topic = params.require(:topic).permit Topic::TOPIC_ATTRS
      topic["status"] = topic["status"].to_i
      topic
    end

    def all_topic
      @topics = Topic.all
    end

    def categories
      @categories = Category.all
    end

    def find_topic
      @topic = Topic.find_by id: params[:id]
      return if topic
      redirect_back fallback_location: admins_topics_path
    end

    def find_user
      @user = Author.find_by id: params[:user_id]
      return if user
      redirect_back fallback_location admins_topics_path
    end
  end
end
