require 'faker'

class AssistantManager
  attr_reader :name

  def initialize(next_handler)
    @next_handler = next_handler
    @name = "Assistant #{Faker::Name.first_name}"
  end

  def handle(order)
    order.line_items.each do |uuid, line_item|
      price = rand(30)
      order.update_line_item(uuid, 'price' => price)
    end

    # sleep rand

    @next_handler.handle(order.dup)
  end
end
