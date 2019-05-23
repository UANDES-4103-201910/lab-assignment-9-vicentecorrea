class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index

  end

  def is_user_logged_in?
    if current_user then true else redirect_to root_path end
  end

  def google_logged_in
    if session["warden.user.user.key"] then true else false end
  end

end
