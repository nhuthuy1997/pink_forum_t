class MessageChannel < ApplicationCable::Channel
  def subscribed
    if params[:post_id].present?
      stream_from "post_channel_#{params[:post_id]}"

    end

    stream_from "user_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message params
    Comment.create(content: params["content"], user: current_user, post_id: params["post_id"], parent_id: params["parent_id"])
  end
end
