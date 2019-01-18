class AddCloumnSenderToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :sender, :string
  end
end
