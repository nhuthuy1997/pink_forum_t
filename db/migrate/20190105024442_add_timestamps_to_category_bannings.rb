class AddTimestampsToCategoryBannings < ActiveRecord::Migration[5.2]
  def change
    add_column :category_bannings, :created_at, :datetime, null: false
    add_column :category_bannings, :updated_at, :datetime, null: false
  end
end
