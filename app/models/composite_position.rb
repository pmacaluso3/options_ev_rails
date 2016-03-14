class CompositePosition
  DELTA_PRICE = 0.01

  attr_reader :spot, :iv, :positions

  def initialize(args = {})
    @spot = args[:spot].to_f
    @iv = args[:iv].to_f
    @positions = args[:positions]
  end

  def value(underlying_price)
    positions.map{ |pos| pos.profit(underlying_price) }.reduce(&:+)
  end

  def sd(position)
    spot * iv * (position.dte / 365) ** 0.5
  end

  def p(position, underlying_price)
    coefficient = 1 / (sd(position) * (2 * Math::PI) ** 0.5)
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

  def expected_value
    underlying_price = domain_low
    ev = 0
    while underlying_price < domain_high
      positions.each do |pos|
        ev += pos.value(underlying_price) * p(pos, underlying_price) * DELTA_PRICE
        underlying_price += 0.01
      end
    end
    ev
  end
end
