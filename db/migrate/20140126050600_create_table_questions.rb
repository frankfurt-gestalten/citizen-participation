class CreateTableQuestions < ActiveRecord::Migration
  create_table :questions do |t|
    t.string :title
    t.text :guid, null: false
    t.text :category
    t.text :link
    t.datetime :pubDate
    t.timestamps
  end
end
