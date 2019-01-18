class ChangeLinkToReceiver < ActiveRecord::Migration[5.2]
  def change
    rename_column :notifications, :link, :receiver
  end
end
