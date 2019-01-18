class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  enum sex: %i(female male)

  has_many :category_bannings, dependent: :destroy
  has_many :topic_bannings, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :images
  has_many :notifications

  # validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i}
  validates :phone, allow_nil: true, format: {with: /\A[[\+\-]?\d+]{10,20}\z/i}
  validates :sex, allow_nil: true, inclusion: {in: sexes.values}

  before_save :default_type

  scope :search, (lambda do |search=""|
    where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
  end)

  def avatar
    self.images.where(current_avatar: true).first
  end

  private

  def default_type
    self.type ||= Author.name
  end
end
