require 'spec_helper'

feature 'Search Subscription' do
  scenario 'user subscribes to search results' do
    visit root_path
    fill_in 'q', with: 'Grindbrunnen'
    click_button 'Search'

    click_link 'Subscribe'

    find_field('search_subscription_query').value.should == 'Grindbrunnen'
    fill_in 'search_subscription_email', with: 'bob@example.com'
    click_button 'Subscribe'

    create(:antraege, title: 'New proposal')
    create(:antraege, title: 'New grindbrunnen')
    SearchSubscription.notify

    email = open_last_email_for 'bob@example.com'
    email.should_not have_body_text 'New proposal'
    email.should have_body_text 'New grindbrunnen'

    SearchSubscription.notify

    email.should == open_last_email_for('bob@example.com')
  end
end