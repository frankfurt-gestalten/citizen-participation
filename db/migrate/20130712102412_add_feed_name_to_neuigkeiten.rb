class AddFeedNameToNeuigkeiten < ActiveRecord::Migration
  def change
    add_column :neuigkeitens, :feed_name, :string
  end
end
