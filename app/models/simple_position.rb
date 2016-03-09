module SimplePosition

  class StanceError < StandardError
  end

  attr_reader :strike, :credit, :stance, :dte

  def initialize(args = {})
    @credit = args[:credit]
    @strike = args[:strike]
    @stance = args[:stance]
    @dte = args[:dte]
  end

  def stance_effect
    case stance
    when :long then 1
    when :short then -1
    end
  end

  def value(underlying_price)
    (payoff(underlying_price) + credit) * stance_effect
  end

  def cost_basis_contribution
    credit * (-stance_effect)
  end
end
