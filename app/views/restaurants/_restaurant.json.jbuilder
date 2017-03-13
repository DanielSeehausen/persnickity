json.extract! restaurant, :id, :name, :grade, :zip, :created_at, :updated_at
json.url restaurant_url(restaurant, format: :json)
