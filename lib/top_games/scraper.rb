module TopGames
  # Scrapes web for current top selling games
  class Scraper

    # Scrape steam charts for game data
    # @param url [String] the web page url
    # @return [Array] An array of {Game games's}
    def scrape_steam_chart(url = 'http://store.steampowered.com/search/?filter=topsellers')
      games = Nokogiri::HTML(open(url)).css('a.search_result_row')

      # Get each game's details
      games.each do |game|
        before_discount = nil
        if (discount = game.css('div.search_discount').text.strip != '')
          before_discount = game.css('div.search_price span').text
          game.css('div.search_price span').remove
        end

        Game.new(game.css('span.title').text, game.first[1],
                 game.css('div.search_price').text.strip[/(\d+[,.]\d+)/].to_f, discount, before_discount)
      end

      Game.all
    end

  end
end