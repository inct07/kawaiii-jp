class ImagesController < ApplicationController
  def index
    @images = Image.includes(:girl)
  end
end