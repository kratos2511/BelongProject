class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end
  
  def items
    puts "****************************************"
    puts current_user.inspect
  end
  
end
