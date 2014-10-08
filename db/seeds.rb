food_types = ["Curry", "Dessert", "Sides", "Breakfast"]
food_types.each {|d| FoodType.where(name: d).first_or_create}

food_preferences = ["Vegetarian", "Vegan", "Meat","Dairy"]
food_preferences.each{|d| FoodPreference.where(name: d).first_or_create}

cuisines = ["Italian", "Mexican", "Indian","Chinese"]
cuisines.each{|d| Cuisine.where(name: d).first_or_create}

for i in 1..50 do
  Pin.create! id: i, name: "test#{i}", board_id: 1, slug: "abc#{i}",
    image: File.open(File.join("#{Rails.root}/app/assets/images", 'currynation.png'))
end

plans = [
  ["Small", 1, 10, 20, 5, 10],
  ["Medium", 5, 50, 50, 10, 30],
  ["Large", 10, 100, 50, 50, 50]
]
plans.each do |name, restaurants, tables, menu_items, storage, price|
  Plan.find_or_create_by name:name, restaurants: restaurants, tables: tables,
    menu_items: menu_items, storage: storage, price: price
end
