class Item < ApplicationRecord
  has_many :action_items, dependent: :destroy
  
  validates_presence_of :hacker_url, :url, :posted_on, :ref_id, :upvotes, :comments, :title
  validates_uniqueness_of :hacker_url, :ref_id
end
