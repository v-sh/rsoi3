class OauthAccountsController < ApplicationController

  def index
    render json: oauth_accounts
  end

  def show
    render json: oauth_account
  end


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

  def update
    if oauth_account.update(oauth_account_params)
      render json: {location: oauth_account_url(@oauth_account)}, status: 200
    else
      render json: @oauth_account.errors, status: :unprocessable_entity
    end
  end

  def destroy
    oauth_account.destroy
    head :no_content
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
  def oauth_account
    @oauth_account ||= oauth_accounts_scope.find(params[:id])
  end
  
  def oauth_accounts
    @oauth_accounts ||= oauth_accounts_scope.all
  end
    
  def oauth_account_params
    params.require(:oauth_account).permit(:email, :telephone, :password)
  end
  
  def oauth_accounts_scope
    OauthAccount
  end
end
