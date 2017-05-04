class GirlsController < ApplicationController
  def index
    @girls = Girl.all
  end

  def show
    @girl = Girl.find(params[:id])
  end
end