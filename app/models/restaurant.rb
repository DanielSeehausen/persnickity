class Restaurant < ApplicationRecord
  has_many :restaurant_violations
  has_many :violations, through: :restaurant_violations
  belongs_to :neighborhood
  validates :zip_code, presence: true

  def self.ACTIVE_GRADES
    ['A', 'B', 'C']
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
    return { :score => score, :date => date }
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

end
