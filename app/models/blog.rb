class Blog < ActiveRecord::Base

  attr_accessible :title, :content, :fotos_attributes
  belongs_to :user

  has_many :comments, as: :commentable
  has_many :fotos, :as => :attachable
  accepts_nested_attributes_for :fotos, :allow_destroy => true, :reject_if => lambda { |a| a[:title].blank? && a[:file].blank? }

  validates_presence_of :title, :content

end
