class AccountAppPermission < ActiveRecord::Base
  belongs_to :oauth_account
  belongs_to :api_application

  def scopes=(scopes)
    self.permitted_scopes = PermissionScope.serialize_scopes(scopes)
  end

  def scopes
    permitted_scopes
  end

end
