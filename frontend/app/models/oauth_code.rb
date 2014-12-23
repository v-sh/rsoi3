# this model needs global refactoring using callback and validations
class OauthCode < ActiveRecord::Base
  belongs_to :account_app_permission

  delegate :oauth_account, to: :account_app_permission
  delegate :api_application, to: :account_app_permission
  delegate :scopes, to: :account_app_permission
  before_validation :generate_code, on: :create

  strip_attributes
  validates_presence_of :code

  def self.trade_to_token(params)
    code = params[:code]
    client_id = params[:client_id]
    client_secret = params[:client_secret]
    code = self.where(code: code).where(token: nil).first
    code && code.api_application.client_id == params[:client_id] &&
      code.api_application.client_secret == params[:client_secret] &&
      code.created_at > Time.now - 10.minute &&
      code.generate_token
  end

  def generate_token
    self.update(token: SecureRandom.hex(50))
    self.update(refresh_token: SecureRandom.hex(50)) unless refresh_token
    self
  end

  def self.get_by_token(token)
    return if !token || token == ""
    self.where(token: token).first
  end

  def self.refresh_token(params)
    code = params[:code]
    client_id = params[:client_id]
    client_secret = params[:client_secret]
    return unless refresh_token && client_id && client_secret
    code = self.where(token: token)
    code && code.api_application.client_id == client_id &&
      code.api_application.client_secret == client_secret &&
      code.generate_token
  end

  protected

  def generate_code
    self.code = SecureRandom.hex(50)
  end

end
