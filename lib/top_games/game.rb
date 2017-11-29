module TopGames
  # Container for game information
  class Game

    attr_accessor :name, :price, :discount, :before_discount, :url

    @all = []

    def initialize(name, url, price = nil, discount = nil, before_discount = nil)
      @name = name
      @url = url
      @price = price
      @discount = discount
      @before_discount = before_discount
      self.class.all << self
    end

    # Returns all game objects in memory
    # @return [Array] An array of {Game games's}
    def self.all
      @all
    end

    # CLear all game's im memory
    # @return [Array] An empty array
    def self.clear
      @all.clear
    end

  end
end