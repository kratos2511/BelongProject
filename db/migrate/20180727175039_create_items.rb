class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :url
      t.string :hacker_url
      t.datetime :posted_on
      t.integer :upvotes
      t.integer :comments

      t.timestamps
    end
    add_index :items, :url, unique: true
    add_index :items, :hacker_url, unique: true
  end
end
