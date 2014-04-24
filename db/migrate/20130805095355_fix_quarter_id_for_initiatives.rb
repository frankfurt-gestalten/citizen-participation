class FixQuarterIdForInitiatives < ActiveRecord::Migration
  def up
    #Initiative.find_each do |initiative|
      #if initiative.lat.present? && initiative.long.present?
     #   qid = Quarter.id_for_coordinates(initiative.long, initiative.lat)
      #  initiative.update_column(:quarter_id, qid)
      #end
    #end
  end

  def down
  end
end
