class CerateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title
      t.string :description
      t.integer :status
      t.references :user, foreign_key: true, index: true
    end
  end
end
