class RenameThreadsToTopics < ActiveRecord::Migration[5.2]
  def change
    rename_table :threads, :topics
  end
end
