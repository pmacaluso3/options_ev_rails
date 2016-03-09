class CompositePosition
  attr_reader :positions, :spot, :sd

  def initialize(args = {})
    @positions = args[:positions]
  end

  def value(underlying_price)
    positions.map{ |pos| pos.profit(underlying_price) }.reduce(&:+)
  end

  def cost_basis
    positions.map(&:cost_basis_contribution).reduce(&:+)
  end
end