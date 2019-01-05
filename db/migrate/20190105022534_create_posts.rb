class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :description
      t.integer :status
      t.integer :views
      t.references :user, foreign_key: true, index: true
      t.references :thread, foreign_key: true, index: true
    end
  end
end
