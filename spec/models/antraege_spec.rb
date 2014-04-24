require 'spec_helper'

describe Antraege do
  describe '.search' do
    it 'searches in titles' do
      first = create(:antraege, title: 'Mehr Sicherheit auf dem Sport- und Spielplatz depot an der Friedensbrucke')
      second = create(:antraege, title: 'Erweiterungsmoglichkeiten auf dem derzeitigen Standort Kalbacher Hauptstrasse prufen')
      third = create(:antraege, title: 'Der Grindbrunnen soll nicht im Depot verstauben!')

      Antraege.search('depo').should match_array [first, third]
    end

    pending 'searches in begruendung'
  end
end
