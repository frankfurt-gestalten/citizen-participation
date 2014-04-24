if Rails.env.production?
  ThinkingSphinx::Index.define :construction, :with => :active_record do
    indexes title, content
    set_property :min_infix_len => 3
  end
end