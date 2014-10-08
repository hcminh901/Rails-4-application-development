json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :description, :slug
  json.url restaurant_url(restaurant, format: :json)
end
