require_relative 'simple_position'

class Call
  include SimplePosition

  def payoff(underlying_price)
    [0, underlying_price - strike].max
  end
end