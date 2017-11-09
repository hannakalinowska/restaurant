class Cashier
  def initialize(next_handler)
    @next_handler = next_handler
    @orders = {}
    @mutex = Mutex.new
  end

  def pay(order_id)
    @mutex.synchronize do
      @orders[order_id].paid = true
    end
    @next_handler.handle(@orders[order_id])
  end

  def outstanding_orders
    @mutex.synchronize do
      @orders.select {|number, order| !order.paid }
    end
  end

  def handle(order)
    @mutex.synchronize do
      @orders[order.number] = order
    end
  end
end
