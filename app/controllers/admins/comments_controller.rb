module Admins
  class CommentsController < BaseController
    before_action :find_post, only: %i(create)
    before_action :find_comment, only: %i(show update destroy)
    before_action :authenticate_user!, except: %i(show)

    def create
      @comment = current_user.comments.create!(comment_params.merge(parent_id: params[:comment][:parent_id]))
    end

    def show
      respond_to do |format|
        format.js
      end
    end

    def update
      comment.update_attributes(comment_params)
    end

    def destroy
      Comment.where(parent_id: comment.id).delete_all
      comment.destroy!
    end

    private

    attr_reader :post, :comment

    def find_post
      @post = Post.find_by id: params[:post_id]
      return if post
      redirect_back fallback_location: admins_root_path
    end

    def comment_params
      params.require(:comment).permit Comment::COMMENT_ATTRS
    end

    def find_comment
      @comment = Comment.find_by id: params[:id]
    end
  end
end
