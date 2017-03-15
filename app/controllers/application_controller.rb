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
    #TODO move to neighborhood model and refactor to a single hash (change view too)
  end

  def not_found
    respond_to do |format|
      format.html { render template: 'static/not_found', layout: false, status: 404 }
      # format.all  { render nothing: true, status: 404 }
    end
  end

end
