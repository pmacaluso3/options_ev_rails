class Calculator
  DELTA_PRICE = 0.01

  attr_reader :spot, :iv, :position

  def initialize(args = {})
    @spot = args[:spot].to_f
    @iv = args[:iv].to_f
    @position = args[:position]
  end

  def sd
    spot * iv * (position.dte / 365) ** 0.5
  end

  def p(underlying_price)
    coefficient = 1 / (sd * (2 * Math::PI) ** 0.5)
    num = (underlying_price - spot) ** 2
    den = 2 * sd ** 2
    coefficient * Math::exp(-num / den)
  end

  def domain_low
    [0, spot - 4 * sd].max
  end

  def domain_high
    spot + 4 * sd
  end

  # wrote this while drunk
  def expected_value
    underlying_price = domain_low
    ev = 0
    while underlying_price < domain_high
      ev += position.value(underlying_price) * p(underlying_price) * DELTA_PRICE
      underlying_price += 0.01
    end
    ev
  end
end
