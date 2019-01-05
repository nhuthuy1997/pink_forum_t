module Admins
  class DashboardsController < BaseController
    def index
      @categories = Category.left_joins(:posts).group(:title).count("posts.id")
      @total_views = Post.sum(:views)
      @posts = Post.where("YEAR(created_at) = #{Date.today.year}").group_by_month(:created_at).count
      @users = User.where("YEAR(created_at) = #{Date.today.year}").group_by_month(:created_at).count
    end
  end
end
