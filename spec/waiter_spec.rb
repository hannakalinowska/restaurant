require 'waiter'
require 'order_printer'

RSpec.describe Waiter do
  let(:waiter) { Waiter.new(OrderPrinter.new) }
  let(:line_items) { [{name: 'Pizza', quantity: 30}]  }

  describe '#place_order' do
    it 'works' do
      expect {
        waiter.place_order(line_items)
      }.to_not raise_error
    end
  end
end
