require 'spec_helper'
include TopGames

RSpec.describe TopGames do
  it 'has a version number' do
    expect(VERSION).not_to be nil
  end

  describe 'Games' do
    game = Game.new('Test', 'http://store.steampowered.com/app/271590/Grand_Theft_Auto_V/', 5.0)

    it 'has a name' do
      expect(game.name).to eq('Test')
    end

    it 'has a url' do
      expect(game.url).to eq('http://store.steampowered.com/app/271590/Grand_Theft_Auto_V/')
    end

    it 'has a price' do
      expect(game.price).to be_a(Float)
    end
  end

  describe 'Scraper' do
    Game.clear
    steam_data = Scraper.new.scrape_steam_chart
    game = Game.all.first.fetch_detailed

    it 'should scrape data from steam' do
      expect(steam_data).to be_a(Array)
      expect(steam_data[0]).to be_a(Game)
      expect(steam_data[0].name).to_not eq('')
      expect(steam_data[0].url).to_not eq('')
      expect(steam_data[0].price).to be_a(Float)
    end

    it 'should scrape detailed game data' do
      expect(game.tags).to be_a(String)
      expect(game.rating).to be_a(String)
    end
  end

  describe 'CLI' do
    cli = CLI.new
    cli.refresh_games
    cli.games.first.fetch_detailed

    it('should have a list of games') do
      expect(cli.games).to be_a(Array)
      expect(cli.games.first).to be_a(Game)
    end

    it('should accept multiple user inputs') do
      expect { cli.switch('help') }.to output(/Lists the current top sellers/).to_stdout
      expect { cli.switch('list') }.to output(/1. /).to_stdout
      expect { cli.switch('1') }.to output(/URL/).to_stdout
      expect(cli.switch('quit')).to eq(true)
    end
  end
end
