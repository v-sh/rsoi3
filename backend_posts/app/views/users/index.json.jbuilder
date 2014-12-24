json.array!(@users) do |user|
  json.extract! user, :id, :displayName, :gplus_url, :image_url, :about_me, :gender, :gplus_id
  json.url user_url(user, format: :json)
end
