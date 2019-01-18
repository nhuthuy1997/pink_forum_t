class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post, foreign_key: :target_id

  enum status: %i(unread read)
  enum type_noti: %i(comment post)

  after_save { NotificationBroadcastJob.perform_later(self) }

  def check_noti?
    notification = Notification.where(type_noti: self.type_noti, target_id: self.target_id, user_id: self.user_id, sender: self.sender).first
    return true unless notification
    return false if notification.unread?

    notification.status = 0
    notification.save
    return false
  end
end
