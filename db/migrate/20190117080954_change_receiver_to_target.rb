class ChangeReceiverToTarget < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :receiver, :target
  end
end
