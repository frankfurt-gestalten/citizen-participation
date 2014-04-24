class AddTypeToConstructions < ActiveRecord::Migration
  def up
    add_column :constructions, :typ, :string
  end
  def down
    remove_column :constructions, :typ
  end
end
