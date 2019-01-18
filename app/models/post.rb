class Post < ApplicationRecord
  enum status: %i(uncheck checked draft publish)

  POST_ATTRS = %w(id title description status content topic_id).freeze

  belongs_to :topic
  belongs_to :author, class_name: User.name, foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :votes, as: :ownerable, dependent: :destroy
  has_many :notifications, foreign_key: :target_id, dependent: :destroy

  validates :title, presence: true, length: {maximum: 250}
  validates :description, length: {maximum: 250}
  validates :content, presence: true, length: {maximum: 7500}

  after_update :create_notification

  delegate :category, to: :topic

  scope :total_views, ->{ sum :views }
  # scope :total_votes, ->{ joins(:votes).sum(:status) }

  def total_votes
    self.votes.sum(:status)
  end

  def create_notification
    return if self.publish?
    sender = self.author
    content = "đã cập nhật bài viết"
    User.joins(:comments).where(comments: {post_id: self.id}).distinct.each do |user|
      next if user.id == self.user_id
      noti = Notification.new user_id: user.id, status: 0, sender: sender.name,
        target: self.title, content: content, target_id: self.id, type_noti: 1
      noti.save if noti.check_noti?
    end
  end
end
