if Rails.env.production?
  ThinkingSphinx::Index.define :initiative, :with => :active_record do
    where "visible = true"
    indexes title, content
    indexes categories.name, :as => :categories
    set_property :min_infix_len => 3
  end
end