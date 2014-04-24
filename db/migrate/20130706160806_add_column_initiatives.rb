class AddColumnInitiatives < ActiveRecord::Migration
  def change
    change_table :initiatives do |t|
      t.boolean :visible
    end
  end
end
