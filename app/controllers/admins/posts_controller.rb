module Admins
  class PostsController < BaseController
    before_action :posts, only: %i(index)
    before_action :find_post, only: %i(show edit update destroy)
    before_action :categories, :topics, only: %i(new edit)

    def index
      respond_to do |format|
        format.html
        format.json { render json: PostsDatatable.new(view_context) }
      end
    end

    def show
      post.views += 1
      post.save
    end

    def new
      @uploader = true
    end

    def create
      if current_user.posts.new(post_params).save
        message = "Tạo bài viết thành công"
        icon = "success"
        path = admins_posts_path
      else
        message = "Tạo bài viết thất bại"
        icon = "warning"
        path = "#"
      end

      @notification = notification(message, icon, path=path)

      respond_to do |format|
        format.js
      end
    end

    def edit; end

    def update
      if params[:editable].present?
        post.update_attributes post_params
        redirect_to [:admins, post]
      else
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
    end

    def destroy
      post.destroy!
      message = "Đã xóa bài viết *#{post.title}* thành công"
      icon = "success"
      @notification = notification(message, icon)

      respond_to do |format|
        format.js
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

    def post_params
      post = params.require(:post).permit Post::POST_ATTRS
      post["status"] = post["status"].to_i
      post
    end
  end
end
