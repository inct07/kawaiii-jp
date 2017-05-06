class Admin::TopController < ApplicationController
  before_action :admin_authenticate

  def index
  end
end