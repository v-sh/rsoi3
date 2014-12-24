class AccountAppPermission < ActiveRecord::Base
  belongs_to :oauth_account
  belongs_to :api_application
  has_many :oauth_codes, dependent: :destroy

  strip_attributes
  validates :api_application_id, uniqueness: {scope: :oauth_account_id}

  def scopes=(scopes)
    self.permitted_scopes = PermissionScope.serialize_scopes(scopes)
  end

  def scopes
    PermissionScope.string_to_scopes(permitted_scopes)
  end

end
