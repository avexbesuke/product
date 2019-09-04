class MapsController < ApplicationController
  def index
    @shop = Map.new
  end
end
