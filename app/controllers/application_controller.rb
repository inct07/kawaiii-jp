class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  PAGE_LIMIT = 30

  def admin_authenticate
    redirect_to root_path unless current_user.admin?
  end
end
