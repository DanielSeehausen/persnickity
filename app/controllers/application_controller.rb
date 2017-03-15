class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :restaurant_phrases

  def logged_in_account
    session[:account_id]
  end

  def not_found
    respond_to do |format|
      format.html { render template: 'static/not_found', layout: false, status: 404 }
      # format.all  { render nothing: true, status: 404 }
    end
  end

  def restaurant_phrases
    @phrases=["Sometimes it's Good to be Picky", "Doggy Bag not Included", "Fresh from the Oven", "Hot and Ready", "Saving Appetites One Restaurant at a Time"]
  end

end
