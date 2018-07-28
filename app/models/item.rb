class Item < ApplicationRecord
  has_many :action_items, dependent: :destroy
end
