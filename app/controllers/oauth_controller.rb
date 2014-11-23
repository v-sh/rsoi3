class OauthController < ApplicationController
  protect_from_forgery except: :token 
  skip_before_action :check_auth, only: :token
  before_action :get_app, except: :token

  helper_method :requested_scopes
  helper_method :api_app

  def confirm
    oauth_code = 
      begin
        perm = account.account_app_permissions.where(api_application: api_app).first ||
          account.account_app_permissions.create(api_application: api_app)
        perm &&
          begin
            perm.scopes += requested_scopes
            perm.save &&
            perm.oauth_codes.create
          end
      end
    if oauth_code && params[:redirect_url]
      redirect_params = {state: params[:state], code: oauth_code.code}
      redirect_to "#{params[:redirect_url]}?#{redirect_params.to_param}"
    else
      error_redirect("something wrong =)")
    end
  end

  def token
    token = OauthCode.trade_to_token(params.permit(:code, :client_id, :client_secret))
    if token
      render json: {token: token.token, token_expired: token.updated_at + 1.hour}
    else
      render json: {error: :incorrect_request}
    end
  end

  def refresh_token
    token = OauthCode.trade_to_token(params.permit(:refresh_token, :client_id, :client_secret))
    if token
      render json: {token: token.token, token_expired: token.updated_at + 1.hour}
    else
      render json: {error: :incorrect_request}
    end
  end

  protected
  def requested_scopes
    PermissionScope.string_to_scopes(params[:scope])
  end

  def get_app
    api_app
    error_redirect("incorrect client_id") unless @api_app
  end

  def api_app
    @api_app ||= ApiApplication.where(client_id: params[:client_id]).first
  end

  def error_redirect(msg)
    if url = params[:redirect_url]
      redirect_to url, error: msg
    else
      redirect_to users_url
    end
  end

end
