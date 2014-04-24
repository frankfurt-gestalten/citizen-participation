require 'spec_helper'

feature 'Posting comments' do
  let(:user) { create(:user) }
  let!(:initiative) { create(:initiative) }

  scenario 'user posts a comment' do
    subscriber = initiative.user
    subscriber.subscriptions.create!(subscribable: initiative)

    sign_in user
    visit initiative_path(initiative)
    fill_in 'comment_content', with: 'This is a comment'
    click_button 'Speichern'

    page.should have_content '1 Kommentar'
    page.should have_content 'This is a comment'

    delivery = ActionMailer::Base.deliveries.last
    delivery.to.should == [subscriber.email]
    delivery.subject.should include 'Neuer Kommentar'
  end
end