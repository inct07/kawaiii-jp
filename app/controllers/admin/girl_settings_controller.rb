class Admin::GirlSettingsController < ApplicationController
  before_action :admin_authenticate

  def index
    @girls = Girl.all
  end

  def show

  end

  def new
  end

  def edit
  end
end