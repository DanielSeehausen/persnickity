class Restaurant < ApplicationRecord
  has_many :restaurant_violations
  has_many :violations, through: :restaurant_violations
  belongs_to :neighborhood
  validates :zip_code, presence: true

  def data_for_score_line_chart
   prev_date = nil #need dis
   time_score = []
   self.restaurant_violations.order('inspection_date ASC').each do |v|
     next if (v.inspection_date == prev_date || v.score.nil?)
     prev_date = v.inspection_date
     time_score << [v.inspection_date,v.score]
   end
   time_score
  end

  def self.ACTIVE_GRADES
    ['A', 'B', 'C']
  end

  def next_id
    return 1 if self.id == Restaurant.all.count
    self.id + 1
  end

  def previous_id
    return Restaurant.all.count if self.id == 1
    self.id - 1
  end

  def get_scores_over_time_for_chartkick
    h = self.get_scores_over_time
    binding.pry
    x_y_pairs = []
    i = 0
    h[:score].each do
      x_y_pairs << [h[:date][i], h[:score][i]]
      i += 1
    end
    return x_y_pairs
  end

  def get_scores_over_time
    dates = []
    scores = []
    prev_date = nil #need dis

    self.restaurant_violations.order('inspection_date ASC').each do |v|
      next if (v.inspection_date == prev_date || v.score == nil)
      prev_date = v.inspection_date
      dates << v.inspection_date
      scores << v.score
    end
    return { :score => scores, :date => dates }
  end

  def get_avg_score_within_year(year)
    comparison_low = "#{year}-01-01"
    comparison_high = "#{year+1}-01-01"
    inspections_in_year = self.restaurant_violations.where('inspection_date < ? AND inspection_date > ?', comparison_high, comparison_low)

    total = 0
    count = 0
    inspections_in_year.each do |v|
      next if v.score == nil
      total += v.score
      count += 1
    end
    return nil if count == 0
    return total/count
  end

  def self.search(search)
    where("name ILIKE ? OR cuisine ILIKE ?", "%#{search}%", "%#{search}%")
  end

end
