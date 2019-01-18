class CreatePostSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :post_subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
    end
  end
end
