class HomeUtil
  def self.create_action_items_for_items(user_id)
    item_count = Item.all.count
    item_action_count = ActionItem.where(user_id: user_id).count
    return if item_count == item_action_count
    items_with_actions = ActionItem.where(user_id: user_id).pluck(:item_id)
    items = Item.where.not(id: items_with_actions)
    
    items.each do |item|
      ActionItem.create(user_id: user_id, item_id: item.id)
    end
  end
end