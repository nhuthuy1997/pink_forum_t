class Morderator < User
  has_many :category_managements
  has_many :categories, through: :category_managements
end
