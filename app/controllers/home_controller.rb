class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end
  
  def items
    set_items_for_user
  end
  
  def user_action
    puts params.inspect
    puts current_user.inspect
    item_id = params[:item][:item_id]
    perform_action = params[:item][:perform_action]
    
    user_action = UserAction.where(user_id: current_user.id, item_id: item_id).first
    user_action = UserAction.new(user_id: current_user.id, item_id: item_id, read: false, deleted: false) if user_action.blank?
    if(perform_action == "delete")
      user_action.deleted = true
      if user_action.save
        @notice = "Error has occured"
      else
        @notice = "Item deleted."
      end
    else
      user_action.read = true
      if user_action.save
        @notice = "Error has occured"
      else
        @notice = "Item marked read."
      end
    end
    set_items_for_user
    render "items"
  end
  
  def set_items_for_user
    deleted_items = UserAction.where(user_id: current_user.id, deleted: true).pluck(:id)
    #Item.left_joins(:user_actions).where("user_actions.user_id IS NULL OR (user_actions.user_id = ? AND user_actions.deleted = ?)", current_user.id, false).select("items.*, user_actions.user_id AS user_id, user_actions.id AS ai_id,user_actions.deleted AS ai_deleted, user_actions.read AS ai_read").order("items.posted_on DESC").to_a
    @items = Item.where.not(id: deleted_items).include(:user_actions).order("posted_on DESC")
  end

end
