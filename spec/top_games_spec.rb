require 'spec_helper'
include TopGames

RSpec.describe TopGames do
  it 'has a version number' do
    expect(VERSION).not_to be nil
  end

  describe 'Games' do
    game = Game.new('Test', 'http://store.steampowered.com/app/271590/Grand_Theft_Auto_V/')

    it 'has a name' do
      expect(game.name).to eq('Test')
    end

    it 'has a url' do
      expect(game.url).to eq('http://store.steampowered.com/app/271590/Grand_Theft_Auto_V/')
    end
  end

  describe 'Scraper' do
    Game.clear
    scraper = Scraper.new
    steam_data = scraper.scrape_steam_chart

    it 'scrapes data from steam' do
      expect(steam_data).to be_a(Array)
      expect(steam_data[0]).to be_a(Game)
      expect(steam_data[0].name).to_not eq('')
      expect(steam_data[0].url).to_not eq('')
    end
  end

  describe 'CLI' do
    it 'should exist for now' do
      expect(CLI).not_to be nil
    end
  end
end
