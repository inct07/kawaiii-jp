class Admin::GirlSettingsController < ApplicationController
  before_action :admin_authenticate

  def index
    @girls = Girl.all
  end

  def new
    @girl = Girl.new
  end

  def create
    Girl.create(girl_params)
    redirect_to admin_girl_settings_path
  end

  def edit
    @girl = Girl.find(params[:id])
    @images = @girl.images
  end

  def update
    girl = Girl.find(params[:id])
    girl.update(girl_params)
    redirect_to admin_girl_settings_path
  end

  def destroy
    girl = Girl.find(params[:id])
    girl.destroy
    redirect_to admin_girl_settings_path
  end

  private

  def girl_params
    params.require(:girl).permit(
      :name, :description_path, :thumbnail_image_id
    )
  end
end