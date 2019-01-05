class CreateCategoryBannings < ActiveRecord::Migration[5.2]
  def change
    create_table :category_bannings do |t|
      t.references :user, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true
      t.integer :duration
      t.string :reason
    end
  end
end
