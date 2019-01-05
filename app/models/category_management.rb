class CategoryManagement < ApplicationRecord
  belongs_to :category
  belongs_to :morderator, class_name: User.name, foreign_key: :user_id
  belongs_to :admins, class_name: User.name, foreign_key: :user_id
end
