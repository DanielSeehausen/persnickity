json.extract! account, :id, :user_name, :password_digest, :email, :created_at, :updated_at
json.url account_url(account, format: :json)
