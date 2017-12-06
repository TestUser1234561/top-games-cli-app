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

      page = bypass_steam_age_check(page) if page.uri.to_s.include?('agecheck')
      puts page.uri
      description = page.css('div.game_description_snippet')
      rating = page.css('div.summary span')
      game.description = description.text.strip unless description.nil?
      game.rating = rating.first.text.strip unless rating.nil?
      game.tags = page.css('div.glance_tags a.app_tag').collect { |tag| tag.text.strip }.join(', ')
      game.developer = page.css('#developers_list a').text
      game.publisher = page.css('.user_reviews .dev_row a').last.text
    end

    # Bypass steam age check verification
    # @param page [Mechanize::Page] Verification page
    # @return [Mechanize::Page] Game page
    def bypass_steam_age_check(page)
      form = page.forms.last
      @agent.submit(form)
    end

  end
end