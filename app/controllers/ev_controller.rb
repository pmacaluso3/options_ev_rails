class EvController < ApplicationController
  def calculate
    p params
    legs = []
    legs_params = params[:position][:legs]
    legs_params.each do |_, l|
      type = CompositePosition::TYPE_MAP[l.delete('type')]
      legs << type.new(l)
    end
    pos_args = params[:position][:underlying].merge({ legs: legs })
    position = CompositePosition.new(pos_args)
    @calculations = {
      ev: position.expected_value,
      cost_basis: position.cost_basis
    }
  end

  def show
    render :calculate
  end
end
