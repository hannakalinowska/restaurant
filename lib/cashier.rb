class Cashier
  def initialize(next_handler)
    @next_handler = next_handler
    @orders = {}
  end

  def pay(order_id)
    @orders[order_id].paid = true
    @next_handler.handle(@orders[order_id])
  end

  def outstanding_orders
    @orders.select {|number, order| !order.paid }
  end

  def handle(order)
    @orders[order.number] = order
  end
end
