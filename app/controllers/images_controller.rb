class ImagesController < ApplicationController
  def index
    @images = Image.includes(:girl, :favorited_users)
  end
end