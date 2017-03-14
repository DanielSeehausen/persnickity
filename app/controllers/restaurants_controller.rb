class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]

  # GET /restaurants
  # GET /restaurants.json
  def index
    restaurant_phrases
    @restaurants = Restaurant.all
    @best_five = Restaurant.all.order("score ASC").where.not(grade: nil).first(5)
    @worst_five = Restaurant.all.order("score DESC").where.not(grade: nil).first(5)
    @badicons = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
    @goodicons = Dir.entries("app/assets/images/my-icons-collection/goodicons").select {|f| !File.directory? f}
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def restaurant_params
      params.require(:restaurant).permit(:name, :grade, :zip)
    end

    def restaurant_phrases
      @phrases=["Sometimes it's Good to be Picky", "Doggy Bag not Included", "Fresh from the Oven", "Hot and Ready", "Saving Appetites One Restaurant at a Time"]
    end

end
