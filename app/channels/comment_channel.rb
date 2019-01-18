class CommentChannel < ApplicationCable::Channel
  def subscribed
    stream_from "post_channel_#{params[:post_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_comment params
    Comment.create(content: params["content"], user: current_user, post_id: params["post_id"], parent_id: params["parent_id"])
  end
end
