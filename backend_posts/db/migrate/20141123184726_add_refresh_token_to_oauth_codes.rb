class AddRefreshTokenToOauthCodes < ActiveRecord::Migration
  def change
    add_column :oauth_codes, :refresh_token, :string
  end
end
