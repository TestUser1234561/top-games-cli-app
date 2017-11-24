module TopGames
  # A simple command line interface for using the top games gem
  class CLI

    attr_accessor :games

    # Displays a list of current top selling games
    def chart(games = @games)
      games.each.with_index(1) { |game, n| puts "#{n}. #{game.name} - #{game.price}" }
    end

    # Refreshes the current game list
    def refresh
      Game.clear
      @games = Scraper.new.scrape_steam_chart
    end

    # Displays a sorted list by price or rating
    # @param arg [String] a sort type
    def sort(arg)
      case arg
        when 'price'
          chart(@games.sort_by(&:price))
        else
          puts "Sort method not recognized, type 'help' to get a list of commands."
      end
    end

    # Calls CLI methods from strings
    # @param input [String] a CLI command
    def switch(input)
      input = input.split(' ')
      case input[0]
        when 'list'
          puts ''
          input.count > 1 ? sort(input[1]) : chart
        when 'help'
          puts 'list        :    Lists the current top sellers'
          puts 'list [sort] :    Displays the list stored by (price, rating)'
          puts 'quit        :    Quits the app'
        when 'quit'
          return true
        else
          puts "Please check your input or use 'help' to get a list of commands!"
      end
      false
    end

    # Starts a new CLI
    # @return [Object] {CLI}
    def self.start
      cli = new
      cli.refresh
      puts '--------| Top Selling Games |--------'
      puts "Type 'help' to get a list of commands!"
      loop { break if cli.switch(gets.chomp.downcase) }
      cli
    end

  end
end