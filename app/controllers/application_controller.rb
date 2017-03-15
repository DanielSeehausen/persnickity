class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in_account
    session[:account_id]
  end

  def not_found
    respond_to do |format|
      format.html { render template: 'static/not_found', layout: false, status: 404 }
      # format.all  { render nothing: true, status: 404 }
    end
  end

end
