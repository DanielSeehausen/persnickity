class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @accounts = Account.all
  end

  def show
    @neighborhood = Neighborhood.find_by(id: Restaurant.where(zip_code: @account.zip_code).first.neighborhood_id)
    @worst_five = @neighborhood.get_bottom_five
    @best_five = @neighborhood.get_top_five
    @badicons = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
    @goodicons = Dir.entries("app/assets/images/my-icons-collection/goodicons").select {|f| !File.directory? f}
    get_relative_grades
    @logged_in_account = logged_in_account
    if logged_in_account
      if logged_in_account==set_account.id
        @logged_in_account = logged_in_account
      else
        @logged_in_account = logged_in_account
        flash[:error] = "Why you messing with people's stuff?"
        redirect_to "accounts/#{@logged_in_account}"
      end
    else
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end

  def new
    if logged_in_account
      redirect_to login_path
    else
      @account = Account.new
    end
  end

  def edit
    if @account.id != logged_in_account
      redirect_to login_path
    end
  end

  def create
    if !Restaurant.find_by(zip_code: account_params["zip_code"])
      flash[:error] = "That's a dirty Zip yo"
      redirect_to new_account_path
    else
      @account = Account.new(account_params)
      respond_to do |format|
        if @account.save
          session[:account_id] = @account.id
          format.html { redirect_to @account, notice: 'Account was successfully created.' }
          format.json { render :show, status: :created, location: @account }
        else
          format.html { render :new }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @account.id != logged_in_account
      redirect_to login_path
    else
      @account.destroy
      respond_to do |format|
        session.clear
        format.html { redirect_to login_path, notice: 'Account was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_account
    @account = Account.find_by(id: params[:id]) or not_found
  end

  def account_params
    params.require(:account).permit(:user_name, :password, :email, :zip_code)
  end

end
