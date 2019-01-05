class Morderator < User
  has_many :category_managements, foreign_key: :user_id, dependent: :destroy
  has_many :categories, through: :category_managements
end
