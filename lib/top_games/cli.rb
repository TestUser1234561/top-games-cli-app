module TopGames
  # A simple command line interface for using the top games gem
  class CLI

    attr_accessor :games, :games_sorted

    # Displays a list of current top selling games
    def chart(games = @games)
      @games_sorted = nil if games.object_id == @games.object_id
      puts ''
      games.each.with_index(1) { |game, n| puts "#{n}. #{game.name}" }
    end

    # Displays a sorted list by price or rating
    # @param arg [String] a sort type
    def sort(arg)
      case arg
        when 'price'
          chart(@games_sorted = @games.sort_by(&:price))
        else
          puts "Sort method not recognized, type 'help' to get a list of commands."
      end
    end

    # Prints more detailed data for a specific game
    # @param num [Integer]
    def print_detailed(num)
      if num.between?(1, @games.count)
        game = @games[num - 1]
        game = @games_sorted[num - 1] unless @games_sorted.nil?

        puts "-----| #{game.name} |-----"
        puts 'Game Bundle!' if game.bundle
        puts "Price          :    #{game.price}"
        unless game.bundle
          puts "Description    :    #{game.description}" unless game.description.empty?
          puts "Rating         :    #{game.rating}"
          puts "Developer      :    #{game.developer}"
          puts "Publisher      :    #{game.publisher}"
          puts "Tags           :    #{game.tags}"
        end
        puts "URL            :    #{game.url}"
      else
        puts 'Game not found. Please check the number entered.'
      end
    end

    # Refresh the current game list
    def refresh_games
      Game.clear
      @games = Scraper.new.scrape_steam_chart
    end

    # Calls CLI methods from strings
    # @param input [String] a CLI command
    def switch(input)
      input = input.split(' ')

      return true if input[0] == 'quit'

      if input[0] == 'list'
        if input.count > 1
          sort(input[1])
        else
          @games_sorted = nil
          chart
        end
      elsif input[0].to_i > 0
        print_detailed(input[0].to_i)
      elsif input[0] == 'help'
        puts 'list        :    Lists the current top sellers'
        puts 'list [sort] :    Displays the list stored by (price, rating)'
        puts '[#]         :    Displays extra details about selected game'
        puts 'quit        :    Quits the app'
      else
        puts "Please check your input or use 'help' to get a list of commands!"
      end

      false
    end

    # Starts a new CLI
    # @return [Object] {CLI}
    def self.start
      cli = new
      puts '--------| Top Selling Games |--------'
      puts 'Please wait for game list to load...'
      cli.refresh_games
      Game.update_all
      cli.chart
      puts "Enter a number to select a game or type 'help' to get a list of commands!"
      loop { break if cli.switch(gets.chomp.downcase) }
      cli
    end

  end
end