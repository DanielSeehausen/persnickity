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
      @neighborhood.get_relative_grades
    end
  end


  private
  
  def set_neighborhood
    @neighborhood = Neighborhood.find_by_slug(params[:id]) or not_found
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:name, :dominant_cuisine)
  end

  def is_number? string
    true if Float(string) rescue false
  end

end
