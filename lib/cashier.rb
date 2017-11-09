class Cashier
  def initialize(bus)
    @bus = bus
    @orders = Queue.new
  end

  def name
    'Cashier'
  end

  def queue_size
    @orders.size
  end

  def pay(order)
    order.paid = true
    @bus.publish('order_paid', order.dup)
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
