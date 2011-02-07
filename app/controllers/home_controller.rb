class HomeController < ApplicationController
  
  def index
    @upload  = Upload.new
    @uploads = Upload.all
  end
end
