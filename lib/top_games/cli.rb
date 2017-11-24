module TopGames
  # A simple command line interface for using the top games gem
  class CLI
    # Starts a new CLI
    # @return [Object] {CLI}
    def self.start
      cli = new
      cli.chart
      cli
    end

    # Outputs a list of current top selling games
    def chart
      puts '######### Top Selling Games ##########'
      Scraper.new.scrape_steam_chart
      Game.all.each.with_index(1) { |game, n| puts "#{n}. #{game.name} - #{game.price}" }
    end
  end
end