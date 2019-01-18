class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :user, foreign_key: true
      t.string :link
      t.boolean :current_avatar
    end
  end
end
