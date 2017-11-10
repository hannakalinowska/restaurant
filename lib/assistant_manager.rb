require 'faker'

class AssistantManager
  attr_reader :name

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
  end

  def handle(message)
    order = message.payload

    order.line_items.each do |uuid, line_item|
      price = rand(30)
      order.update_line_item(uuid, 'price' => price)
    end

    sleep 0.1

    @bus.publish(message.reply('order_priced', order))
  end
end
