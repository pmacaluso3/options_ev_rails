require 'spec_helper'

describe Put do
  describe '#value' do
    let(:high_expiry) { 11 }
    let(:mid_expiry) { 10 }
    let(:low_expiry) { 9 }

    context 'long' do
      let(:long_put) { described_class.new({ stance: :long, strike: 10, price: 0.5 }) }

      context 'out of the money' do
        it 'is worth -price'do
          expect(long_put.value high_expiry).to eq(-long_put.price)
        end
      end

      context 'in the money' do
        it 'is worth (strike - expiry) - price' do
          expect(long_put.value low_expiry).to eq(long_put.strike - low_expiry - long_put.price)
        end
      end

      context 'at the money' do
        it 'is worth -price' do
          expect(long_put.value mid_expiry).to eq(-long_put.price)
        end
      end
    end

    context 'short' do
      let(:short_put) { described_class.new({ stance: :short, strike: 10, price: 0.5 }) }

      context 'out of the money' do
        it 'is worth price' do
          expect(short_put.value high_expiry).to eq(short_put.price)
        end
      end

      context 'in the money' do
        it 'is worth price - (strike - expiry)' do
          expect(short_put.value low_expiry).to eq(short_put.price - (short_put.strike - low_expiry))
        end
      end

      context 'at the money' do
        it 'is worth price' do
          expect(short_put.value mid_expiry).to eq(short_put.price)
        end
      end
    end
  end
end