class RemoveDateFromNeuigkeiten < ActiveRecord::Migration
  def up
    Neuigkeiten.find_each do |neuigkeiten|
      if neuigkeiten.date
        neuigkeiten.update_column(:datum, neuigkeiten.date)
      end
    end

    remove_column :neuigkeitens, :date
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
