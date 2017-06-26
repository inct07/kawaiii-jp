class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  PAGE_LIMIT = 30

  def admin_authenticate
    return redirect_to user_session_path unless user_signed_in?
    redirect_to root_path unless current_user.admin?
  end
end
