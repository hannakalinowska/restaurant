require 'faker'

class AssistantManager
  attr_reader :name

  def initialize(bus)
    @bus = bus
    @name = "Assistant #{Faker::Name.first_name}"
  end

  def handle(order)
    order.line_items.each do |uuid, line_item|
      price = rand(30)
      order.update_line_item(uuid, 'price' => price)
    end

    # sleep rand

    @bus.publish('order_priced', order.dup)
  end
end
