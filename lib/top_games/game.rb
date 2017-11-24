module TopGames
  # Container for game information
  class Game
    attr_accessor :name, :price, :discount, :before_discount

    @all = []

    def initialize(name, price = nil, discount = nil, before_discount = nil)
      @name = name
      @price = price
      @discount = discount
      @before_discount = before_discount
      self.class.all << self
    end

    def self.all
      @all
    end
  end
end