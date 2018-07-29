class CreateActionItems < ActiveRecord::Migration[5.2]
  def change
    create_table :action_items do |t|
      t.references :user, foreign_key: true
      t.references :item, foreign_key: true
      t.boolean :read, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
