class Admin < User
  has_many :categories, foreign_key: :user_id, dependent: :destroy
  has_many :category_managements, foreign_key: :user_id, dependent: :destroy
end
