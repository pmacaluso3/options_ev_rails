require_relative 'simple_position'

class Stock
  include SimplePosition

  def payoff(underlying_price)
    underlying_price
  end
end