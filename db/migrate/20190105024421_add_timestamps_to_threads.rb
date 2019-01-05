class AddTimestampsToThreads < ActiveRecord::Migration[5.2]
  def change
    add_column :threads, :created_at, :datetime, null: false
    add_column :threads, :updated_at, :datetime, null: false
  end
end
