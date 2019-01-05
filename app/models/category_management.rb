class CategoryManagement < ApplicaitonRecord
  belongs_to :category
  belongs_to :morderator, class_name: User.name
end
