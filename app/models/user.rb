class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable

  enum sex: %i(female male)

  has_many :category_bannings
  has_many :topic_bannings
  has_many :votes
  has_many :topics
  has_many :posts
  has_many :comments

  validates :name, presence: true, length: {maximum: 50}
  validates :email, presence: true, uniqueness: true, format: {with: Regexp.new(Settings.user.regex_email)}
  validates :phone, allow_nil: true, format: {with: Regexp.new(Settings.user.regex_email)}
  validates :sex, allow_nil: true, inclusion: {in: sexes.values}
end
