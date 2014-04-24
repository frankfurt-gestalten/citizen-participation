class ChangeColumnConstructions < ActiveRecord::Migration
  def up
    remove_column :constructions, :source_id
    add_column :constructions, :source_id, :integer, :limit => 8
  end

  def down
    remove_column :constructions, :source_id
    add_column :constructions, :source_id, :string
  end
end
