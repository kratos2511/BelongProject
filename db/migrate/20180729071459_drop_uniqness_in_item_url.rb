class DropUniqnessInItemUrl < ActiveRecord::Migration[5.2]
  def change
    remove_index :items, column: :url
  end
end
