require 'rainbow'

class OrderPrinter
  def handle(order)
    # puts order.to_json
    puts Rainbow("Order #{order.number} paid").bright.green
  end
end
