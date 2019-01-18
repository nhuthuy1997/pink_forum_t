class ChangeColumnDefaultPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_default :posts, :views, 0
  end
end
