require 'rainbow'

class OrderPrinter
  attr_reader :order_count

  def initialize
    @order_count = 0
  end

  def handle(order)
    puts Rainbow("Order #{order.number} paid").bright.green
    @order_count += 1
  end
end
