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

