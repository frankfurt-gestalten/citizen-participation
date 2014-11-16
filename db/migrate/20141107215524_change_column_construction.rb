class ChangeColumnConstruction < ActiveRecord::Migration
  def change
    change_column :constructions, :description_long,  :text
  end
end