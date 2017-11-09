class Cashier
  def initialize(next_handler)
    @next_handler = next_handler
    @orders = Queue.new
  end

  def pay(order)
    order.paid = true
    @next_handler.handle(order)
  end

  def pay_outstanding_orders
    counter = 0
    until @orders.empty?
      order = @orders.pop()
      pay(order)
      counter += 1
    end
    counter
  end

  def handle(order)
    @orders.push(order)
  end
end
