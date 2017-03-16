class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]



  def index
    if params[:search]
      @found_rests = Restaurant.search(params[:search])
    end
    @restaurants = Restaurant.all
    @best_five = Restaurant.all.order("score ASC").where.not(grade: nil).first(5)
    @worst_five = Restaurant.all.order("score DESC").where.not(grade: nil).first(5)
    @badicons = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
    @goodicons = Dir.entries("app/assets/images/my-icons-collection/goodicons").select {|f| !File.directory? f}
  end

  def show
    @violations = @restaurant.restaurant_violations.sort_by{|v| v.inspection_date}.reverse
    #@violations_array = [@restaurant.restaurant_violations, ,RestaurantViolation.all]
  end


  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:id]) or not_found
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :grade, :zip)
    end

end
