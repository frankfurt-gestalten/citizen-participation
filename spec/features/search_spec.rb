require 'spec_helper'

feature 'Search' do
  background do
    create(:antraege, title: 'Mehr Sicherheit auf dem Sport- und Spielplatz an der Friedensbrucke')
    create(:antraege, title: 'Erweiterungsmoglichkeiten auf dem derzeitigen Standort Kalbacher Hauptstrasse prufen')
    create(:antraege, title: 'Der Grindbrunnen soll nicht im Depot verstauben!')
  end

  scenario 'user searches for Grindbrunnen' do
    visit root_path
    fill_in 'q', with: 'Grindbrunnen'
    click_button 'Search'

    page.should_not have_content 'Mehr Sicherheit'
    page.should have_content 'Der Grindbrunnen'
  end
end