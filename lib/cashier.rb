require 'faker'

class Cashier
  attr_reader :name

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
  end

  def handle(message)
    order = message.order

    order.paid = true
    sleep 0.01
    @bus.publish(message.reply('order_paid', order))
  end
end
