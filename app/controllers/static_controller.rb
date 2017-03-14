class StaticController < ApplicationController

  def new
  end

  def about
    @pictures = Dir.entries("app/assets/images/my-icons-collection/png").select {|f| !File.directory? f}
  end

  def contact
  end

  def login
  end

end
