namespace :update_db do
  desc "pull information from JSON file and update DB"
  task :update_violations => :environment do
    require 'open-uri'
    require 'json'

    url = open("https://data.cityofnewyork.us/resource/xx67-kt59.json?$order=inspection_date%20desc").read
    results = JSON.parse(url)

    results.each do |result|
      name = result["dba"]
      cuisine = result["cuisine_description"]
      zip_code = result["zipcode"].to_i
      phone = result["phone"]
      address = result["building"] + " " + result["street"]

      restaurant = Restaurant.find_or_create_by(name: name, cuisine: cuisine, zip_code: zip_code,
      phone: phone, address: address)
      if result["grade"]
        restaurant.grade = result["grade"]
        restaurant.save
      end

      code = result["violation_code"]
      description = result["violation_description"]
      critial_flag = result["critical_flag"]

      violation = Violation.find_or_create_by(code: code, description: description, critial_flag: critial_flag)


      inspection_type = result["inspection_type"]
      inspection_date = result["inspection_date"]
      score = result["score"].to_i

      restaurant_violation = RestaurantViolation.find_or_create_by(inspection_type: inspection_type,
      inspection_date: inspection_date, score: score, restaurant: restaurant, violation: violation)
    end

  end
end
