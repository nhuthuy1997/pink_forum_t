class CommentBroadcastJob < ApplicationJob
  queue_as :default
    
  def perform(record, action, post_id)
    ActionCable.server.broadcast "post_channel_#{post_id}", comment: record, action: action
  end
end
