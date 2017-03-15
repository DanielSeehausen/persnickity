class NeighborhoodsController < ApplicationController

  def index
    @neighborhoods = Neighborhood.all
  end

  def show
    if params[:id] == '0'
      redirect_to '/neighborhoods/1'
    else
      set_neighborhood
      @hood = @neighborhood
      get_relative_grades
    end
  end

  private
    def set_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end

    def neighborhood_params
      params.require(:neighborhood).permit(:name, :dominant_cuisine)
    end
end
