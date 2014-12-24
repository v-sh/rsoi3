class Post < ActiveRecord::Base
  belongs_to :user
  strip_attributes only: [:text]

  validates_presence_of :user_id, :text

  def destroy
    self.class.backend_conn[id].delete
  end
  
  def save
    if id
      self.class.backend_conn[id].put(post: as_json) do |response, request, result|
        case response.code
        when 200
          true
        else
          errors.add(:base, :invalid)
        end
      end
    else
      self.class.backend_conn.post(post: as_json)do |response, request, result|
        case response.code
        when 200
          true
        else
          errors.add(:base, :invalid)
        end
      end
    end
  end

  def self.find(id)
    res = backend_conn[id].get
    self.new(JSON.parse(res))
  end

  def self.load_collection(params)
    res = JSON.parse(backend_conn.get({params: params})).deep_symbolize_keys
    res[:items] = res[:items].map do |item|
      self.new(item)
    end

    user_res = User.load_collection(ids: res[:items].map{|i| i[:user_id]}.join(","))
    res[:items].each do |post|
      post.user = user_res[:items].select{|user| user.id == post.user_id}.first
    end
    
    res
  end
  protected

  def self.backend_conn
    RestClient::Resource.new "localhost:5002/posts"
  end
end
