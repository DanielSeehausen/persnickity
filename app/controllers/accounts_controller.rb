class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    #this is for the frontend, put where needed
    @hood = Neighborhood.find_by(id: Restaurant.where(zip_code: @account.zip_code).first.neighborhood_id)
    a_avg = @hood.get_relative_dominance_of_grade('A')
    b_avg = @hood.get_relative_dominance_of_grade('B')
    c_avg = @hood.get_relative_dominance_of_grade('C')
    @rel_grades = [{'A': a_avg}, {'B': b_avg}, {'C': c_avg}]

    @logged_in_account = logged_in_account

    if logged_in_account
      if logged_in_account==set_account.id
        @logged_in_account = logged_in_account
      else
        byebug
        @logged_in_account = logged_in_account
        flash[:error] = "Why you messing with people's stuff?"
        redirect_to "accounts/#{@logged_in_account}"
      end
    else
      flash[:error] = "You must be logged in"
      redirect_to login_path
    end
  end

  # GET /accounts/new NOT ACCESSIBLE WHEN LOGGED IN
  def new
    if logged_in_account
      redirect_to login_path
    else
      @account = Account.new
    end
  end

  # GET /accounts/1/edit CAN ONLY EDIT OWN ACCOUNT
  def edit
    if @account.id != logged_in_account
      redirect_to login_path
    end
  end

  # POST /accounts
  # POST /accounts.json
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

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
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

  # DELETE /accounts/1 CAN ONLY DELETE OWN ACCOUNT
  # DELETE /accounts/1.json
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
  # Use callbacks to share common setup or constraints between actions.
  def set_account
    if !Account.find_by(id: params[:id])
      redirect_to homepage_path #TODO redirect to 404 when available
    else
      @account = Account.find_by(id: params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_name, :password, :email, :zip_code)
  end

end
