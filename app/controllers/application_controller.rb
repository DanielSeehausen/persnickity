class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in_account
    session[:account_id]
  end

end
