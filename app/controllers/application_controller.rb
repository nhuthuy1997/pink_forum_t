class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :redirect_to_right_path, :notifications

  def redirect_to_right_path
    path_name = request.path

    return if destroy_user_session_path == path_name

    if user_signed_in?
      namespace = current_user.type.pluralize.underscore
      return if path_name.include? namespace
      redirect_to eval namespace << "_root_path"
    else
      return if path_name.include? Settings.devise.users_path
      redirect_to new_user_session_path
    end
  end

  def notification message, icon, path="#"
    {message: message, icon: icon, path: path}
  end

  def uploader params
    Image.new(link: params[:file], user: current_user)
  end
  
  def notifications
    return unless user_signed_in?
    @notifications = current_user.notifications
  end
end
