require 'rainbow'

require_relative 'handle_order'

class OrderPrinter < HandleOrder
  def handle(order)
    # puts order.to_json
    puts Rainbow("Order #{order.number} paid").bright.green
  end
end
