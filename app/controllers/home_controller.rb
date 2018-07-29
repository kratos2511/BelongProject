class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end
  
  def items
    HomeUtil::create_action_items_for_items(current_user.id)
    @items = get_items_for_user
  end
  
  def user_action
    item_id = params[:item][:item_id]
    perform_action = params[:item][:perform_action]
    success = false
    action_item = ActionItem.where(user_id: current_user.id, item_id: item_id).first
    action_item = ActionItem.new(user_id: current_user.id, item_id: item_id, read: false, deleted: false) if action_item.blank?
    if(perform_action == "delete")
      action_item.deleted = true
      if action_item.save
        success = true
        notice = " Item was deleted successfully."
      else
        notice = " Unable to delete item from listing."
      end
    else
      action_item.read = true
      if action_item.save
        success = true
        notice = " Item was marked read successfully."
      else
        notice = " Unable to mark item as read."
      end
    end
    respond_to do |format|
      format.json { render json: {item_id: action_item.item_id, perform_action: perform_action, notice: notice, success: success} }
    end
  end
  
  def get_items_for_user
    Item.joins(:action_items).where("action_items.user_id = ? AND action_items.deleted = ?", current_user.id, false).select("items.*, action_items.user_id AS user_id, action_items.id AS ai_id,action_items.deleted AS ai_deleted, action_items.read AS ai_read").order("items.posted_on DESC")
  end

end
