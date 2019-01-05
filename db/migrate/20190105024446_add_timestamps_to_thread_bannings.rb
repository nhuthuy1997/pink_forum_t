class AddTimestampsToThreadBannings < ActiveRecord::Migration[5.2]
  def change
    add_column :thread_bannings, :created_at, :datetime, null: false
    add_column :thread_bannings, :updated_at, :datetime, null: false
  end
end
