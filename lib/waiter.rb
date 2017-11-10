require_relative 'order'

class Waiter
  attr_reader :name, :order_count

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
    @order_count = 0
  end

  def place_order(line_items)
    order = Order.new

    order.waiter = @name
    line_items.each do |line_item|
      order.add_line_item(line_item)
    end

    message = Message.new('order_placed', order).tap do |m|
      m.correlation_id = order.number
    end
    @bus.publish(message)

    @order_count += 1
  end
end
