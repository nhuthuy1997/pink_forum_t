class AddTimestampsToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :created_at, :datetime, null: false
    add_column :votes, :updated_at, :datetime, null: false
  end
end
