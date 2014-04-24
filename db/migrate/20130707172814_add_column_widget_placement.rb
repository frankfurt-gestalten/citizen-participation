class AddColumnWidgetPlacement < ActiveRecord::Migration
  def change
    add_column :widget_placements, :weight, :integer
  end
end