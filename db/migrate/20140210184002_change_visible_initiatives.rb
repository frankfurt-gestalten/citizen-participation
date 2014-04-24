class ChangeVisibleInitiatives < ActiveRecord::Migration
  def up
    change_column :initiatives, :visible, :boolean, :default => true
  end

  def down
    change_column :initiatives, :visible, :boolean, :default => nil
  end
end