module TopGames
  # Container for game information
  class Game

    attr_accessor :name, :price, :discount, :before_discount, :url, :description, :rating, :tags, :developer,
                  :publisher, :bundle

    @all = []

    def initialize(name, url, price = nil, discount = nil, before_discount = nil)
      @name = name
      @url = url
      @price = price
      @discount = discount
      @before_discount = before_discount
      self.class.all << self
    end

    # Update games detailed data
    def fetch_detailed
      Scraper.new.scrape_steam_detailed(self)
    end

    # Returns all game objects in memory
    # @return [Array] An array of {Game games's}
    def self.all
      @all
    end

    # Clear all game's im memory
    # @return [Array] An empty array
    def self.clear
      @all.clear
    end

    # Update every game's detailed data
    # @return [Array] An array of {Game games's}
    def self.update_all
      @all.each { |game| game.fetch_detailed }
    end

  end
end