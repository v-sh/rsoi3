module PermissionScope
  PermittedScopes = [:users, :posts].freeze

  def self.string_to_scopes(scopes)
    String(scopes).split.map(&:to_sym).select{|scope| PermittedScopes.include? scope}.to_set
  end

  def self.serialize_scopes(scopes)
    scopes.select{|scope| PermittedScopes.include? scope}.join(" ")
  end

  module Filter
    
    module ClassMethods

      def require_permission(scopes, params = {})
        scopes = Array(scopes)
        scopes.each do |scope|
          skip_before_action "check_app_permission_#{scope}", params
          before_action "check_app_permission_#{scope}", params
        end
      end

    end
      
    PermittedScopes.each do |scope|
      define_method "check_app_permission_#{scope}" do
        if api_token
          render json: {error: "this application can't access #{scope}"}, status: 403 unless api_token.scopes.include? scope
        end
      end
    end
    
    def self.included(base)
      base.extend ClassMethods
    end
  end
end
