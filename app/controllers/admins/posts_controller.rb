module Admins
  class PostsController < BaseController
    before_action :posts, only: %i(index)
    before_action :find_post, only: %i(update)
    before_action :categories, :topics, :markdown_editor, only: %i(new)

    def index
      respond_to do |format|
        format.html
        format.json { render json: PostsDatatable.new(view_context) }
      end
    end

    def new; end

    def update
      ActiveRecord::Base.transaction do
        begin
          if params[:accept].to_i == 1
            post.update(status: :publish)
            message = "Đã chuyển trạng thái bài *#{post.title}* thành công khai"
            icon = "success"
          else
            post.update(status: :checked)
            message = "Đã chuyển trạng thái bài *#{post.title}* thành đã kiểm tra"
            icon = "success"
          end
        rescue
          message = "Đã có lỗi xảy ra"
          icon = "warning"
        end
      
        @notification = notification(message, icon)

        respond_to do |format|
          format.js
        end
      end
    end

    private

    attr_reader :posts, :post, :topics, :categories

    def posts
      @posts = Post.all
    end

    def find_post
      @post = Post.find_by id: params[:id]

      return if post
      redirect_to admins_posts_path
    end

    def categories
      @categories = Category.all
    end

    def topics
      @topics = Topic.all
    end
  end
end
