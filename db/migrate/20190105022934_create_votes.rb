class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :ownerable_id, index: true
      t.string :ownerable_type, index: true
      t.integer :status
    end
  end
end
