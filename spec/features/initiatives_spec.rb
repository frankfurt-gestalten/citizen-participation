require 'spec_helper'

feature 'initiative page', :js do
  scenario 'loads markers with ajax when changing location' +
    ', streets or quarters' do
    Initiative.new(:lat => '50.759047', :long => '6.130028', :content => 'qwe').
      save :validate => false
    Initiative.new(:lat => '50.76', :long => '6.14', :content => 'asd').
      save :validate => false
    visit initiatives_path
    page.should have_css '.awesome-marker-icon-red', :count => 2

    pending 'CartoDB is disabled in test, Kommune is not fetched.'
    select 'Alsdorf', :from => 'kommune'
    page.should_not have_css '.awesome-marker-icon-red'
    select 'Aachen', :from => 'kommune'
    page.should have_css '.awesome-marker-icon-red', :count => 2
  end
end
