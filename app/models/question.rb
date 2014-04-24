class Question < ActiveRecord::Base
  attr_accessible :title, :category, :description, :link, :guid, :pubDate
  belongs_to :attachable, :polymorphic => true

  def self.create_from_feed(item)
    model = where(guid: item.search('guid').first.content).first
    puts item.search('guid').first.content
    puts model
    if model.blank?
      model = new(guid: item.search('guid').first.content)
    end
    puts model
    model.update_attributes!(title: item.search('title').first.content,
    description: item.search('description').first.try(:content), pubDate: Time.parse(item.search('pubDate').first.content), link: item.search('link').first.try(:content), category: item.search('category').first.try(:content))
  end
end
