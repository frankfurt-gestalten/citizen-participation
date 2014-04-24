class CreateWidgetPlacements < ActiveRecord::Migration
  def change
    create_table :widget_placements do |t|
      t.string :controller
      t.string :action
      t.string :position
      t.references :widget

      t.timestamps
    end
  end
end
