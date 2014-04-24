class AddLastReminderInitiatives < ActiveRecord::Migration
  def up
    add_column :initiatives, :last_reminder, :datetime
  end

  def down
    remove_column :initiatives, :last_reminder, :datetime
  end
end
