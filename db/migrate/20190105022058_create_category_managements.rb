class CreateCategoryManagements < ActiveRecord::Migration[5.2]
  def change
    create_table :category_managements do |t|
      t.references :user, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true
    end
  end
end
