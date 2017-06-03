class Admin::GirlSettingsController < ApplicationController
  before_action :admin_authenticate

  def index
    @girls = Girl.all
  end

  def new
    @girl = Girl.new
  end

  def create
    @girl = Girl.new(girl_params)
    begin
      ActiveRecord::Base.transaction do
        @girl.save!
        get_girl_image_path(@girl)
      end
      flash.notice = '美少女を追加しました。'
      redirect_to admin_girl_settings_path
    rescue GoogleCustomSearch::RequestLimit
      flash.alert = '画像取得APIのリクエスト上限値に達しました'
      redirect_to admin_girl_settings_path
    rescue => e
      flash.alert = e.message
      render action: 'new'
    end
  end

  def edit
    @girl = Girl.find(params[:id])
    @images = @girl.images
  end

  def update
    @girl = Girl.find(params[:id])
    @girl.assign_attributes(girl_params)
    begin
      @girl.save!
      flash.notice = '美少女の設定を更新しました。'
      redirect_to admin_girl_settings_path
    rescue => e
      @images = @girl.images
      flash.alert = e.message
      render action: 'edit'
    end
  end

  def destroy
    girl = Girl.find(params[:id])
    begin
      girl.destroy!
      flash.notice = '美少女を削除しました。'
    rescue => e
      flash.alert = '美少女の削除に失敗しました。'
    end
    redirect_to admin_girl_settings_path
  end

  private

  def get_girl_image_path(girl)
    paths = GoogleCustomSearch.new.bulk_get_image_paths(girl.name)
    images = paths.map { |path| Image.new(girl: girl, img_path: path) }
    Image.import! images
  end

  def girl_params
    params.require(:girl).permit(
      :name, :description_path, :thumbnail_image_id
    )
  end
end
