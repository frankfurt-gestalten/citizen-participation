class Widget < ActiveRecord::Base
  self.inheritance_column = nil

  attr_accessible :type, :name, :content, :placements_attributes, :title

  has_many :placements, class_name: 'WidgetPlacement', dependent: :destroy
  accepts_nested_attributes_for :placements, :allow_destroy => true

  def partial_name
    {
      'recent_comments' => 'widgets/recent_comments',
      'static' => 'widgets/static',
      'recent_iniatives' => 'widgets/recent_iniatives',
      'recent_updated_initiatives' => 'widgets/recent_updated_initiatives',
      'recent_neuigkeiten' => 'widgets/recent_neuigkeiten',
      'start_iniative' => 'widgets/start_iniative',
      'recent_vorlagen' => "widgets/recent_vorlagen",
      'newsletter_signup' => "widgets/newsletter_signup"
    }[type]
  end
end