class NeighborhoodsController < ApplicationController
  before_action :set_neighborhood, only: [:show]

  def index
    @neighborhoods = Neighborhood.all
  end

  def show
    #this was refactored a little as the set_neighborhood before action should take care of it
    if is_number?(params[:id])
      @neighborhood = Neighborhood.find(params[:id])
      redirect_to "/neighborhoods/#{@neighborhood.slug}"
    else
      set_neighborhood
      @rel_grades = @neighborhood.get_relative_grades
      @worst_five = @neighborhood.get_bottom_five
      @best_five = @neighborhood.get_top_five
      @badicons = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
      @goodicons = Dir.entries("app/assets/images/my-icons-collection/goodicons").select {|f| !File.directory? f}
    end
  end


  private

  def set_neighborhood
    if params[:id].to_i.to_s == params[:id]
      @neighborhood = Neighborhood.find(params[:id]) or not_found
    else
      @neighborhood = Neighborhood.find_by_slug(params[:id]) or not_found
    end
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :dominant_cuisine)
  end

  def is_number? string
    true if Float(string) rescue false
  end

end
