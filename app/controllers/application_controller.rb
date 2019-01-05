class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :redirect_to_right_path

  def redirect_to_right_path
    path_name = request.path

    return if destroy_user_session_path == path_name || request.method != Settings.http_verbs.get

    if user_signed_in?
      namespace = current_user.type.pluralize.underscore
      return if path_name.include? namespace
      redirect_to eval namespace << "_root_path"
    else
      return if path_name.include? Settings.devise.users_path
      redirect_to new_user_session_path
    end
  end
end
