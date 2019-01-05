class ChangeThreadIdToTopicIdInPost < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :thread_id, :topic_id
  end
end
