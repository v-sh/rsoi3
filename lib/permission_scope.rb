module PermissionScope
  PermittedScopes = [:users, :posts].freeze

  def self.string_to_scopes(scopes)
    scopes.split.map(&:to_sym).select{|scope| PermittedScopes.include? scope}
  end

  def self.serialize_scopes(scopes)
    scopes.join(" ")
  end
end
