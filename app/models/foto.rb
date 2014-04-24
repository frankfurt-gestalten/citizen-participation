class Foto < ActiveRecord::Base
  attr_accessible :title, :file
  belongs_to :attachable, :polymorphic => true

  mount_uploader :file, FotoUploader

  validates_presence_of :file
end
