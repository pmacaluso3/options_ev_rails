class CompositePosition
  DELTA_PRICE = 0.01


  TYPE_MAP = {
    'call' => Call,
    'put' => Put,
    'stock' => Stock
  }

  attr_reader :spot, :iv, :legs

  def initialize(args = {})
    @spot = args[:spot].to_f
    @iv = args[:iv].to_f
    @legs = args[:legs]
  end

  def value(underlying_price)
    legs.map{ |leg| leg.profit(underlying_price) }.reduce(&:+)
  end

  def sd(position)
    spot * iv * (position.dte / 365) ** 0.5
  end

  def p(position, underlying_price)
    coefficient = 1 / (sd(position) * (2 * Math::PI) ** 0.5)
    num = (underlying_price - spot) ** 2
    den = 2 * sd(position) ** 2
    coefficient * Math::exp(-num / den)
  end

  def largest_sd
    legs.map { |leg| sd(leg) }.max
  end

  def domain_low
    [0, spot - 4 * largest_sd].max
  end

  def domain_high
    spot + 4 * largest_sd
  end

  def cost_basis
    legs.map { |leg| leg.credit }.reduce(&:+)
  end

  def expected_value
    underlying_price = domain_low
    ev = 0
    while underlying_price < domain_high
      legs.each do |leg|
        ev += leg.value(underlying_price) * p(leg, underlying_price) * DELTA_PRICE
        underlying_price += DELTA_PRICE
      end
    end
    ev
  end
end
