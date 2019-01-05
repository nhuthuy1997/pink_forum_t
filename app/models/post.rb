class Post < ApplicationRecord
  enum status: %i(uncheck checked draft publish)

  belongs_to :topic
  belongs_to :author, class_name: User.name, foreign_key: :user_id
  has_many :comments, dependent: :destroy
  has_many :votes, as: :ownerable, dependent: :destroy

  delegate :category, to: :topic

  scope :total_views, ->{ sum :views }
  # scope :total_votes, ->{ joins(:votes).sum(:status) }

  def total_votes
    self.votes.sum(:status)
  end
end
