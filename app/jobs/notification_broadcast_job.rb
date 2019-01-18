class NotificationBroadcastJob < ApplicationJob
  def perform(record)
    ActionCable.server.broadcast "user_channel_#{record.user_id}",
      notification: render_notification(record)
  end

  private

  def render_notification(record)
    NotificationsController.render partial: 'notifications/notification', locals: {notification: record}
  end
end
