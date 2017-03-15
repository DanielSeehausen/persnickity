class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show]
  before_action :set_icons, only: [:index, :show]

  def index
    @restaurants = Restaurant.all
    @best_five = Restaurant.all.order("score ASC").where.not(grade: nil).first(5)
    @worst_five = Restaurant.all.order("score DESC").where.not(grade: nil).first(5)
  end

  def show
    @violations = @restaurant.restaurant_violations.sort_by{|v| v.inspection_date}.reverse
    #@violations_array = [@restaurant.restaurant_violations, ,RestaurantViolation.all]
  end


  private
    def set_restaurant
      unless @restaurant = Restaurant.find_by(id: params[:id])
        not_found
      end
    end

    def set_icons
      @badicons = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
      @goodicons = Dir.entries("app/assets/images/my-icons-collection/goodicons").select {|f| !File.directory? f}
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :grade, :zip)
    end


end
