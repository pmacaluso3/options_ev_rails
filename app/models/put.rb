require_relative 'simple_position'

class Put
  include SimplePosition

  def payoff(underlying_price)
    [0, strike - underlying_price].max
  end
end

