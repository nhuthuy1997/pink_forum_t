class Admin < User
  has_many :categories, foreign_key: :user_id
end
