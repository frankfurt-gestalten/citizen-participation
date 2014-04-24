class AddColumnContentConstruction < ActiveRecord::Migration
  def up
    add_column :constructions, :content, :text
  end

  def down
    remove_column :constructions, :content, :text
  end
end
