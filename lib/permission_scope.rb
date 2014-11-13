module PermissionScope
  PermittedScopes = [:users, :posts].freeze

  def self.string_to_scopes(scopes)
    String(scopes).split.map(&:to_sym).select{|scope| PermittedScopes.include? scope}.to_set
  end

  def self.serialize_scopes(scopes)
    scopes.select{|scope| PermittedScopes.include? scope}.join(" ")
  end

  module Filter

    def self.require_permission(perms)
      perms = Array(perms)
      skip_before_action :check_permission_app_scope
      before_action :check_permission_app_scope
      self.define_method :check_permission_app_scope do
        if api_app
          render json: {error: :access_denied}, status: 403 unless perms.map{|perm| api_app.scopes.include? perm}.all?
        end
      end
    end
  end
end
