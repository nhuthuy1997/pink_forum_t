class ChangeTypeToTypeNoti < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :type, :type_noti
  end
end
