class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    @best_five = Restaurant.best_five_health_score
    @worst_five = Restaurant.worst_five_health_score
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id]) or not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :grade, :zip)
    end
end
