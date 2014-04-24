if Rails.env.production?
  ThinkingSphinx::Index.define :neuigkeiten, :with => :active_record do
    indexes title, content
    #set_property :enable_star => 1
    set_property :min_infix_len => 3
  end
end