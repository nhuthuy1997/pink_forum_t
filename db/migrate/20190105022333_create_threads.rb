class CreateThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :threads do |t|
      t.string :title
      t.string :description
      t.integer :status
      t.integer :votes
      t.references :user, foreign_key: true, index: true
      t.references :category, foreign_key: true, index: true
    end
  end
end
