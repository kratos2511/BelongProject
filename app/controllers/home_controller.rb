class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  end
  
  def items
    @items = Item.left_joins(:action_items).where("action_items.user_id IS NULL OR action_items.user_id != ?", current_user.id).select("items.*, action_items.user_id AS user_id, action_items.id AS ai_id,action_items.deleted AS ai_deleted, action_items.read AS ai_read").order("items.posted_on DESC").to_a
  end
  
  def updates_action_item
    
  end
  
end
