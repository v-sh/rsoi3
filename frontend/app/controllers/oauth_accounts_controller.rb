class OauthAccountsController < ApplicationController
  before_action :set_oauth_account, only: [:show, :edit, :update, :destroy]
  
  skip_before_action :check_auth, only: [:login, :new, :create]

  # GET /oauth_accounts
  # GET /oauth_accounts.json
  def index
    @oauth_accounts = OauthAccount.all
  end

  # GET /oauth_accounts/1
  # GET /oauth_accounts/1.json
  def show
  end

  # GET /oauth_accounts/new
  def new
    @oauth_account = OauthAccount.new
  end

  # GET /oauth_accounts/1/edit
  def edit
  end

  # POST /oauth_accounts
  # POST /oauth_accounts.json
  def create
    @oauth_account = OauthAccount.new(oauth_account_params)

    respond_to do |format|
      if @oauth_account.save
        do_login(@oauth_account)
        format.html { redirect_to params[:redirect_uri] || users_url }
        format.json { render :show, status: :created, location: @oauth_account }
      else
        format.html { render :new }
        format.json { render json: @oauth_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oauth_accounts/1
  # PATCH/PUT /oauth_accounts/1.json
  def update
    respond_to do |format|
      if @oauth_account.update(oauth_account_params)
        format.html { redirect_to @oauth_account, notice: 'Oauth account was successfully updated.' }
        format.json { render :show, status: :ok, location: @oauth_account }
      else
        format.html { render :edit }
        format.json { render json: @oauth_account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oauth_accounts/1
  # DELETE /oauth_accounts/1.json
  def destroy
    @oauth_account.destroy
    respond_to do |format|
      format.html { redirect_to oauth_accounts_url, notice: 'Oauth account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def login
    account = OauthAccount.auth_account(params[:email], params[:password])
    if account
      do_login(account)
      redirect_to params[:redirect_uri] || users_url
    end
  end

  def logout
    do_logout
  end

  def me
    render json: account
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oauth_account
      @oauth_account = OauthAccount.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oauth_account_params
      params.require(:oauth_account).permit(:email, :telephone, :password)
    end
end
