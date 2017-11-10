require 'rainbow'

class OrderPrinter
  attr_reader :order_count

  def initialize
    @order_count = 0
  end

  def handle(message)
    puts Rainbow("Order #{message.order.number} paid").bright.green
    @order_count += 1
  end
end
