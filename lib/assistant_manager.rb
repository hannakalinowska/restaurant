class AssistantManager
  PRICES = {
    'Pizza' => 12.50,
    'Coffee' => 3.50,
    'Chocolate' => 24,
    'Ice cream' => 12,
    'Ketchup' => 5,
    'Chips' => 8,
    'Crisps' => 7,
  }

  def initialize(next_handler)
    @next_handler = next_handler
  end

  def handle(order)
    order.line_items.each do |uuid, line_item|
      price = PRICES[line_item['name']]
      order.update_line_item(uuid, 'price' => price)
    end

    @next_handler.handle(order)
  end
end

