require 'spec_helper'

describe Stock do
  describe '#value' do
    let(:high_expiry) { 11 }
    let(:mid_expiry) { 10 }
    let(:low_expiry) { 9 }

    context 'long' do
      let(:long_stock) { described_class.new({ stance: :long, price: 10 }) }

      context 'out of the money' do
        it 'is worth expiry - price'do
          expect(long_stock.value low_expiry).to eq(low_expiry - long_stock.price)
        end
      end

      context 'in the money' do
        it 'is worth expiry - price' do
          expect(long_stock.value high_expiry).to eq(high_expiry - long_stock.price)
        end
      end

      context 'at the money' do
        it 'is worth 0' do
          expect(long_stock.value mid_expiry).to eq(0)
        end
      end
    end

    context 'short' do
      let(:short_stock) { described_class.new({ stance: :short, price: 10 }) }

      context 'out of the money' do
        it 'is worth -(expiry - price)' do
          expect(short_stock.value low_expiry).to eq(-(low_expiry - short_stock.price))
        end
      end

      context 'in the money' do
        it 'is worth -(expiry - price)' do
          expect(short_stock.value high_expiry).to eq(-(high_expiry - short_stock.price))
        end
      end

      context 'at the money' do
        it 'is worth 0' do
          expect(short_stock.value mid_expiry).to eq(0)
        end
      end
    end
  end
end