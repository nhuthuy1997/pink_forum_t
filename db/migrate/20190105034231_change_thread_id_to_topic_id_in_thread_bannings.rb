class ChangeThreadIdToTopicIdInThreadBannings < ActiveRecord::Migration[5.2]
  def change
    rename_column :topic_bannings, :thread_id, :topic_id
  end
end
