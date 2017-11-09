class AssistantManager
  def initialize(next_handler)
    @next_handler = next_handler
  end

  def handle(order)
    order.line_items.each do |uuid, line_item|
      price = rand(30)
      order.update_line_item(uuid, 'price' => price)
    end

    @next_handler.handle(order.dup)
  end
end
