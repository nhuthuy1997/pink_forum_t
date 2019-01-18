class Comment < ApplicationRecord
  COMMENT_ATTRS = %w(id content user_id post_id).freeze

  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  after_create_commit { CommentBroadcastJob.perform_later(self, "create", self.post_id) }
  after_update_commit { CommentBroadcastJob.perform_later(self, "update", self.post_id) }
  after_destroy_commit { CommentBroadcastJob.perform_later(self.id, "destroy", self.post_id) }
  after_save :create_notification

  def create_notification
    sender = self.user
    target = self.post
    content = "đã bình luận vào bài viết"
    User.joins(:comments).where(comments: {post_id: self.post_id}).distinct.each do |user|
      next if user.id == self.user_id
      noti = Notification.new user_id: user.id, status: 0, sender: sender.name,
        target: target.title, content: content, target_id: target.id, type_noti: 0
      noti.save if noti.check_noti?
    end
  end
end
