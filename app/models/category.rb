class Category < ApplicationRecord
  enum status: %i(unpublish publish)

  CATEGORY_ATTRS = %w(id title description status user_id).freeze

  belongs_to :admin, class_name: User.name, foreign_key: :user_id
  has_many :category_bannings
  has_many :users, through: :category_bannings
  has_many :category_managements, dependent: :destroy
  has_many :morderators, through: :category_managements
  has_many :topics, dependent: :destroy
  has_many :posts, through: :topics

  validates :title, presence: true, length: {maximum: 250}, uniqueness: true
  validates :description, length: {maximum: 250}

  scope :publishes, ->{where status: :publish}

  delegate :total_views, to: :posts

  private

end
