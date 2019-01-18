class AddTimeStampToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :created_at, :datetime, null: false
    add_column :notifications, :updated_at, :datetime, null: false
  end
end
