class Category < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name

  has_and_belongs_to_many :antraeges, join_table: 'categories_antraeges'
  has_and_belongs_to_many :initiatives, join_table: 'categories_initiatives'
end
