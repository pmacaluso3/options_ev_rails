require 'spec_helper'

describe Call do
  describe '#value' do
    let(:high_expiry) { 11 }
    let(:mid_expiry) { 10 }
    let(:low_expiry) { 9 }

    context 'long' do
      let(:long_call) { described_class.new({ stance: :long, strike: 10, price: 0.5 }) }

      context 'out of the money' do
        it 'is worth -price'do
          expect(long_call.value low_expiry).to eq(-long_call.price)
        end
      end

      context 'in the money' do
        it 'is worth (expiry - strike) - price' do
          expect(long_call.value high_expiry).to eq(high_expiry - long_call.strike - long_call.price)
        end
      end

      context 'at the money' do
        it 'is worth -price' do
          expect(long_call.value mid_expiry).to eq(-long_call.price)
        end
      end
    end

    context 'short' do
      let(:short_call) { described_class.new({ stance: :short, strike: 10, price: 0.5 }) }

      context 'out of the money' do
        it 'is worth price' do
          expect(short_call.value low_expiry).to eq(short_call.price)
        end
      end

      context 'in the money' do
        it 'is worth price - (expiry - strike)' do
          expect(short_call.value high_expiry).to eq(short_call.price - (high_expiry - short_call.strike))
        end
      end

      context 'at the money' do
        it 'is worth price' do
          expect(short_call.value mid_expiry).to eq(short_call.price)
        end
      end
    end
  end
end