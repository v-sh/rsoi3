class User < ActiveRecord::Base

  def destroy
    self.class.backend_conn[id].delete
  end
  
  def save
    if id
      self.class.backend_conn[id].put(user: as_json) do |response, request, result|
        case response.code
        when 200
          true
        else
          errors.add(:base, :invalid)
        end
      end
    else
      self.class.backend_conn.post(user: as_json)do |response, request, result|
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
    res
  end
  protected

  def self.backend_conn
    RestClient::Resource.new "localhost:5001/users"
  end
end
