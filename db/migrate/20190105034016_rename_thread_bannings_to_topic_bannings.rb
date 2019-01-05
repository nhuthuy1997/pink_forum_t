class RenameThreadBanningsToTopicBannings < ActiveRecord::Migration[5.2]
  def change
    rename_table :thread_bannings, :topic_bannings
  end
end
