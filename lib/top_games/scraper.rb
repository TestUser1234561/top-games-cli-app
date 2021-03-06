module TopGames
  # Scrapes web for current top selling games
  class Scraper

    attr_accessor :agent

    def initialize
      @agent = Mechanize.new
      @agent.cookie_jar.load("#{__dir__}/cookies.yaml")
    end

    # Scrape steam charts for game data
    # @param url [String] web page URL
    # @return [Array] An array of {Game games's}
    def scrape_steam_chart(url = 'http://store.steampowered.com/search/?filter=topsellers')
      games = Mechanize.new.get(url).css('a.search_result_row')

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

    # Scrape detailed game data from steam
    # @param game [Game] web page URL
    # @return [Game] A {Game}
    def scrape_steam_detailed(game)
      return game.bundle = true unless game.url.to_s.include?('app')

      page = agent.get(game.url)

      description = page.css('div.game_description_snippet')
      rating = page.css('div.summary span').first
      game.description = description.nil? ? nil : description.text.strip
      game.rating = rating.nil? ? 'No user reviews' : rating.text.strip
      game.tags = page.css('div.glance_tags a.app_tag').collect { |tag| tag.text.strip }.join(', ')
      game.developer = page.css('#developers_list a').text
      game.publisher = page.css('.user_reviews .dev_row a').last.text
      game
    end

  end
end