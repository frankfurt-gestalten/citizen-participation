class AddColumnTitleWidgets < ActiveRecord::Migration
 def change
  change_column :widgets, :content, :text
  add_column :widgets, :title, :string
 end
end
