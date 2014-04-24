task :initiator_reminder => :environment do
  Initiative.where('updated_at < ? or last_reminder < ?', 4.weeks.ago, 4.weeks.ago).find_each do |initiative|
    unless initiative.comments.where(user_id: initiative.user_id).created_after(6.weeks.ago).exists?
      InitiativenMailer.initiator_reminder(initiative).deliver
    end
  end
end