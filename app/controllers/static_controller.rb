class StaticController < ApplicationController

  def new
    @pie_chart = {'A'=>Restaurant.where(grade: "A").count, 'B'=>Restaurant.where(grade: "B").count, 'C and Other'=>Restaurant.where(grade: "C").count}
  end

  def about
    @pictures = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
  end

  def contact
  end

  def login
  end

end
