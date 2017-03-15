class NeighborhoodsController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
  end

  def show
    if params[:id] == '0'
      redirect_to '/neighborhoods/park-slope' #TODO redirect to 404
    else
      if is_number?(params[:id])
        @neighborhood = Neighborhood.find(params[:id])
        redirect_to "/neighborhoods/#{@neighborhood.slug}"
      else
        set_neighborhood
        get_relative_grades
      end
    end
  end

  private
    def set_neighborhood
      @neighborhood = Neighborhood.find_by_slug(params[:id])
    end

    def neighborhood_params
      params.require(:neighborhood).permit(:name, :dominant_cuisine)
    end

    def is_number? string
      true if Float(string) rescue false
    end

end
