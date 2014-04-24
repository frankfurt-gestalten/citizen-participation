class AddQuarterToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :quarter_id, :integer
  end
end
