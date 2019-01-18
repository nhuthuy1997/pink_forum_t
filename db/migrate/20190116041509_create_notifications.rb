class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.string :content
      t.integer :status
      t.integer :type
      t.string :link
    end
  end
end
