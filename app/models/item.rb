class Item < ApplicationRecord
  has_many :user_actions, dependent: :destroy
  has_many :users, through: :user_actions
  validates_presence_of :hacker_url, :url, :posted_on, :ref_id, :upvotes, :comments, :title
  validates_uniqueness_of :hacker_url, :ref_id
  
  after_create_commit :create_user_action_for_all_user
  
  def create_user_action_for_all_user
    users = User.all
    users.each do |user|
      user_action = UserAction.create(user_id: user.id, item_id: self.id)
    end
  end
end
