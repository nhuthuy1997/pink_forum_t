module Authors
  class PostsController < BaseController
    def index
      @posts = Post.where(status: :publish).includes(:comments, :votes, :author).page(params[:page] || 1).per(Settings.page.per_page)
    end

    def show

    end
  end
end
