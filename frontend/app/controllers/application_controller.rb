#FRONT
class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :check_auth
  before_action :check_token_expiration
  after_action :soa_session_save
  include PermissionScope::Filter

  def do_login(oauth_account)
    session[:account_id] = oauth_account.id
  end

  def do_logout
    soa_session[:account_id] = nil
    redirect_to login_oauth_accounts_url
  end

  def account
    OauthAccount.where(id: soa_session[:account_id]).first ||
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
        format.html {redirect_to login_oauth_accounts_url(redirect_uri: params[:redirect_uri])}
        format.json {render json: {error: 'unauthorized'}, status: 401 }
      end
    end
  end

  def check_token_expiration
    if api_token
      render json: {error: "token expired"} unless Time.now < api_token.updated_at + 1.hour
    end
  end

  def soa_session
    @soa_session ||= 
      begin
        base = soa_session_conn
        if session[:soa_session_key]
          begin
            JSON.parse(base[session[:soa_session_key]].get).deep_symbolize_keys
          rescue
            create_session
          end
        else
          create_session
        end[:obj_data]
      end || {}
  end

  def soa_session=(soa_session)
    @soa_session = soa_session
  end

  def create_session
    base = soa_session_conn
    JSON.parse(base.post({})).deep_symbolize_keys.tap do |new_session|
      session[:soa_session_key] = new_session[:key]
    end
  end
  
  def soa_session_save
    soa_session_conn[session[:soa_session_key]].put({session: @soa_session})
  end

  private
  def soa_session_conn
    RestClient::Resource.new 'localhost:4000/sessions'
  end

end
