class AddRefIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :ref_id, :integer
    add_index :items, :ref_id, unique: true
  end
end
