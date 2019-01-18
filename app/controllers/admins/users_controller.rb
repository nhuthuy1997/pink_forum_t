module Admins
  class UsersController < BaseController
    before_action :find_category, :find_topic, only: %i(search)

    def info
      respond_to do |format|
        format.json {render json: current_user: current_user}
      end
    end
  
    def search
      @users = User.search params

      respond_to do |format|
        format.js
      end
    end

    private

    attr_reader :users, :category

    def find_category
      @category = Category.find_by id: params[:category_id]
    end

    def find_topic
      @category = Category.find_by id: params[:topic_id]
    end
  end
end
