require_relative 'order'

class Waiter
  def initialize(handle_order)
    @handle_order = handle_order
  end

  def name
    'Bob'
  end

  def place_order(line_items)
    order = Order.new

    order.waiter = name
    line_items.each do |line_item|
      order.add_line_item(line_item)
    end

    @handle_order.handle(order)
  end
end
