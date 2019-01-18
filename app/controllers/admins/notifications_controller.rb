module Admins
  class NotificationsController < BaseController
    before_action :find_notification

    def update
      @notification.status = :read
      @notification.save

      respond_to do |format|
        format.js
      end
    end

    private

    def find_notification
      @notification = Notification.find_by id: params[:id]
    end
  end
end
