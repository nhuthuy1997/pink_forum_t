module Admins
  class VotesController < BaseController
    before_action :find_post, :find_vote

    def create
      ActiveRecord::Base.transaction do
        if vote.present?
          vote.status += params[:status].to_i
          vote.save
        else
          post.votes.create(user: current_user, status: params[:status].to_i)
        end
      rescue
      end

      respond_to do |format|
        format.js
      end
    end

    private

    attr_reader :post, :vote

    def find_post
      @post = Post.find_by id: params[:post_id]
      return if post
      redirect_back fallback_location: admins_posts_path
    end

    def find_vote
      @vote = post.votes.find_by user: current_user
    end
  end
end
