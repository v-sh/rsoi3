class OauthAccount < ActiveRecord::Base
  has_many :account_app_permissions

  before_save :encrypt_password
  after_save :clear_password

  attr_accessor :password
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :confirmation => true #password_confirmation attr
  validates_length_of :password, :in => 6..20, :on => :create  

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def clear_password
    self.password = nil
  end

  def self.auth_account(account_email, password)
    return unless account = self.where(email: account_email).first
    account if BCrypt::Engine.hash_secret(password, account.salt) == account.encrypted_password
  end

end
