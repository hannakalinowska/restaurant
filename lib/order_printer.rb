require 'pry'
require_relative 'handle_order'

class OrderPrinter < HandleOrder
  def handle(order)
    # puts order.to_json
    puts "Order #{order.number} paid"
  end
end
