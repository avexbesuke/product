class MapsController < ApplicationController
  def index
    @map = Map.new
    @maps = Map.order("created_at DESC")
    @books = current_user.books.pluck('title')
  end

  def create
    @map = Map.new(map_params)
    @map.book_id = Book.find_by(title: params.require(:map).require(:book)).id
    if @map.save
      redirect_to maps_path
    else
      render :index
    end
  end

  def destroy
    @map = Map.find(params[:id])
    if @map.delete
      redirect_to maps_path
    else
      render :index
    end
  end

  private

  def map_params
    params.require(:map).permit(:memori, :address, :latitude, :longitude, images: []).merge(user_id: current_user.id)
  end
end
