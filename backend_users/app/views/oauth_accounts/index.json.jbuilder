json.array!(@oauth_accounts) do |oauth_account|
  json.extract! oauth_account, :id, :email, :telephone, :encrypted_password, :salt
  json.url oauth_account_url(oauth_account, format: :json)
end
