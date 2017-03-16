namespace :update_db do
  desc "adds years and avg values of them as parseable strings to the database as a row in neighborhoods"
  task :add_years_and_avgs_to_neighborhoods => :environment do

    # add_column :neighborhoods, :years_for_avgs, :string
    # add_column :neighborhoods, :avg_yearly_scores, :string

    counter = 0
    Neighborhood.all.each do |n|
      scores_years = n.get_avg_scores_per_year
      n.avg_yearly_scores = scores_years[:scores].join("-")
      n.years_for_avgs = scores_years[:years].join("-")
      n.save
      counter += 1
      print "\r #{counter}"
    end

  end
end
