require 'faker'

class Cashier
  attr_reader :name

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
  end

  def handle(order)
    order.paid = true
    sleep 0.01
    @bus.publish('order_paid', order.dup)
  end
end
