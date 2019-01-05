class Author < User
  has_many :category_bannings, foreign_key: :user_id
  has_many :categories, through: :category_bannings
  has_many :topic_bannings, foreign_key: :user_id
  has_many :topics, through: :topic_bannings
end
