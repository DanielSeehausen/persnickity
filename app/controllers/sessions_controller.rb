class SessionsController < ApplicationController

  def new
    if logged_in_account
      @account = Account.find(logged_in_account)
      redirect_to @account
    else
      @account = Account.new
    end
  end

  def create
    @account = Account.find_by(user_name: account_params[:user_name])
    if @account
      if @account.authenticate(account_params[:password])
        session[:account_id] = @account.id
        redirect_to @account
      end
    else
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end

  private
  # # Use callbacks to share common setup or constraints between actions.
  # def set_account
  #   @account = Account.find(params[:id])
  # end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_name, :password, :email)
  end
end
