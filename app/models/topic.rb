class Topic < ApplicationRecord
  enum status: %i(unpublish publish close)

  TOPIC_ATTRS = %w(id title description status user_id category_id).freeze

  belongs_to :user
  belongs_to :category
  has_many :votes, as: :ownerable, dependent: :destroy
  has_many :posts
  has_many :topic_bannings
  has_many :users, through: :topic_bannings

  delegate :total_views, to: :posts

  def total_votes
    self.votes.sum(:status)
  end
end
