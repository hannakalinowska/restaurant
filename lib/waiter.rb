require_relative 'order'

class Waiter
  attr_reader :name

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
  end

  def place_order(line_items)
    order = Order.new

    order.waiter = @name
    line_items.each do |line_item|
      order.add_line_item(line_item)
    end

    @bus.publish('order_placed', order.dup)
  end
end
