class Session < ActiveRecord::Base
  before_validation :generate_key, on: :create
  before_validation :encode_data
  strip_attributes only: :key
  validates :key, presence: true, length: {minimum: 50}

  def as_json(params = {})
    super params.merge({only: :key, methods: :obj_data})
  end

  def obj_data
    @obj_data ||= JSON.parse(data || "{}")
  end
  
  def obj_data=(data)
    @obj_data = data
  end

  protected

  def generate_key
    self.key = SecureRandom.hex(50)
  end

  def encode_data
    self.data = @obj_data.to_json if @obj_data
  end
end
