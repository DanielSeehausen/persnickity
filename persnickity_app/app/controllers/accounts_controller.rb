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
    @logged_in_account = logged_in_account
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
    @account = Account.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def account_params
    params.require(:account).permit(:user_name, :password, :email, :zip_code)
  end

end
