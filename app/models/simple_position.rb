module SimplePosition

  class StanceError < StandardError
  end

  attr_reader :strike, :price, :stance, :dte

  def initialize(args = {})
    @price = args[:price].to_f
    @strike = args[:strike].to_f
    @stance = args[:stance]
    @dte = args[:dte].to_f
  end

  def stance_effect
    case stance
    when 'long' then 1
    when 'short' then -1
    end
  end

  def value(underlying_price)
    payoff(underlying_price) * stance_effect + credit
  end

  def credit
    price * (-stance_effect)
  end
end
