require_relative 'order'

class Waiter < ThreadedHandler
  def place_order(line_items)
    order = Order.new

    order.waiter = @name
    line_items.each do |line_item|
      order.add_line_item(line_item)
    end

    @queue.push(order)
  end
end
