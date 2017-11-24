module TopGames
  # Scrapes web for current top selling games
  class Scraper

    # Scrape steam charts for game data
    # @param url [String] the web page url
    # @return [Array] An array of {Game games's}
    def scrape_steam_chart(url = 'http://store.steampowered.com/search/?filter=topsellers')
      games = Nokogiri::HTML(open(url)).css('a.search_result_row')

      games.each do |game|
        # Get game price and any discount's
        before_discount = nil
        if (discount = game.css('div.search_discount').text.strip != '')
          before_discount = game.css('div.search_price span').text
          game.css('div.search_price span').remove
        end
        price = game.css('div.search_price').text.strip

        Game.new(game.css('span.title').text, price, discount, before_discount)
      end
    end

  end
end