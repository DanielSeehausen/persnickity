#PLEASE NOTE: THIS IS FOR POPULATING AN EMPTY DATABASE. IF THIS IS TO BE RUN OVER EXISTING DATA, ADDITIONAL JOIN TABLE ENTRIES WILL BE MADE (RESTAURANT VIOLATIONS)
#TODO if needed, alter and save as update task as well

# example of hash information
#{
#  "cuisine_description" : "American",
#  "dba" : "OLD HOMESTEAD",
#  "record_date" : "2017-03-13T06:02:02",
#  "boro" : "MANHATTAN",
#  "inspection_date" : "2016-02-25T00:00:00",
#  "building" : "56",
#  "zipcode" : "10011",
#  "score" : "24",
#  "phone" : "2122429040",
#  "street" : "9 AVENUE",
#  "grade" : "B",
#  "critical_flag" : "Critical",
#  "camis" : "40364715", #<---- restaurant ID from api
#  "action" : "Violations were cited in the following area(s).",
#  "violation_code" : "06D",
#  "violation_description" : "Food contact surface not properly washed, rinsed and sanitized after each use and following any activity when contamination may have occurred.",
#  "grade_date" : "2016-02-25T00:00:00",
#  "inspection_type" : "Cycle Inspection / Re-inspection"
#}

namespace :update_db do
  desc "pull information from JSON file and update DB"
  task :seed_from_json => :environment do
    require 'open-uri'
    require 'json'

    url = open("https://data.cityofnewyork.us/resource/xx67-kt59.json?$limit=30000").read #running this task in heroku breaks at 48870

    results = JSON.parse(url)
    counter = 0
    results.each do |result|
      #assignments pertaining to the restaurant
      next if !result.key?("zipcode") #if zip_code does not exist move on to the next record
      zip_code  = result["zipcode"].to_i
      camis     = result.key?("camis") ? result["camis"] : nil
      name      = result.key?("dba") ? result["dba"] : nil
      grade     = result.key?("grade") ? result["grade"] : nil
      cuisine   = result.key?("cuisine_description") ? result["cuisine_description"] : nil
      phone     = result.key?("phone") ? result["phone"] : nil

      if (result.key?("building") && result.key?("street"))
        address = result["building"] + " " + result["street"]
      elsif result.key?("street")
        address = result["street"]
      end

      #assignments pertaining to the violation
      code            = result.key?("violation_code") ? result["violation_code"] : nil
      description     = result.key?("violation_description") ? result["violation_description"] : nil
      if result.key?("critical_flag")
        critical_flag = (result["critical_flag"] == "Critical") ? true : false
      else
        critical_flag = nil
      end

      #assignments pertaining to the RestaurantViolation instance
      inspection_date = result.key?("inspection_date") ? result["inspection_date"].split("T", 1)[0] : nil
      score           = result.key?("score") ? result["score"].to_i : nil #this is the restaurant's score during that whole inspection (not from the violation alone).

      r = Restaurant.where(camis: camis).first_or_create({ camis: camis, name: name, grade: grade, zip_code: zip_code, phone: phone, address: address, cuisine: cuisine})
      v = Violation.where(code: code).first_or_create({ code: code, description: description, critical_flag: critical_flag})
      RestaurantViolation.create({ restaurant_id: r.id, violation_id: v.id, inspection_date: inspection_date, score: score })

      counter += 1
      print "\r #{counter}"
    end

  end
end
