class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_auth
  before_action :check_token_expiration
  include PermissionScope::Filter

  def do_login(oauth_account)
    session[:account_id] = oauth_account.id
  end

  def do_logout
    session[:account_id] = nil
    redirect_to login_oauth_accounts_url
  end

  def account
    OauthAccount.where(id: session[:account_id]).first ||
      api_token && api_token.oauth_account
  end

  def api_token
    OauthCode.get_by_token(get_api_token_params)
  end

  def get_api_token_params
    params[:access_token]
  end

  def check_auth
    if !account
      respond_to do |format|
        format.html {redirect_to login_oauth_accounts_url, redirect_uri: request.original_url}
        format.json {render json: {error: 'unauthorized'}, status: 401 }
      end
    end
  end

  def check_token_expiration
    if api_token
      render json: {error: "token expired"} unless Time.now < api_token.updated_at + 1.hour
    end
  end

end
