class AddInitiativeIdNeuigkeiten < ActiveRecord::Migration
 def change
    add_column :neuigkeitens, :initiative_id, :integer
  end
end
