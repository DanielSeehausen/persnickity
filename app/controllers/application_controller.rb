class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in_account
    session[:account_id]
  end

  def get_relative_grades
    a_avg = @neighborhood.get_relative_dominance_of_grade('A')
    b_avg = @neighborhood.get_relative_dominance_of_grade('B')
    c_avg = @neighborhood.get_relative_dominance_of_grade('C')
    @rel_grades = [{'A': a_avg}, {'B': b_avg}, {'C': c_avg}]
  end

end
