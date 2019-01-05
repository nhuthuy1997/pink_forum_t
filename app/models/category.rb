class Category < ApplicationRecord
  enum status: %i(unpublish publish)

  CATEGORY_ATTRS = %w(id title description status user_id).freeze

  belongs_to :admin, class_name: User.name, foreign_key: :user_id
  has_many :category_bannings
  has_many :users, through: :category_bannings
  has_many :category_managements
  has_many :categories, through: :category_managements

  validates :title, presence: true, length: {maximum: 250}, uniqueness: true
  validates :description, length: {maximum: 250}
  validates :status, inclusion: {in: statuses.values}

  scope :publishes, ->{where status: :publish}

  private

end
