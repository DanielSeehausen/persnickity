namespace :update_db do
  desc "assigns the most recent score a restaurant received to its score field"
  task :assign_current_restaurant_scores => :environment do

    # Restaurant.all.each { |r| r.score = r.restaurant_violations.order("inspection_date DESC").first.score }
    counter = 0
    Restaurant.all.each do |r|
      r.score = r.restaurant_violations.order("inspection_date DESC").first.score
      r.save
      counter += 1
      print "\r #{counter}"
    end

  end
end
