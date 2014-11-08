class ApiApplication < ActiveRecord::Base
  before_create :generate_id_and_secret

  protected
  def generate_id_and_secret
    self.client_id = SecureRandom.hex(50)
    self.client_secret = SecureRandom.hex(50)
  end
end
