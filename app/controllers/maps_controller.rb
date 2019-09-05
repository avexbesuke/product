class MapsController < ApplicationController
  def index
    @map = Map.new
  end

  def create
    binding.pry
    @map = Map.new(map_params)
    if @map.save
      redirect_to maps_path
    else
      render :index
    end
  end

  private
  def map_params
    params.require(:map).permit(:memorie, :book_id, :address, :latitude, :longitude,images: [])
  end
end
