class Cook
  INGREDIENTS = {
    'Pizza' => %w(olives tomatoes peppers),
    'Coffee' => %w(coffee),
    'Chocolate' => %w(cocoa sugar),
    'Ice cream' => %(milk sugar ice cream),
    'Ketchup' => %w(tomatoes sugar),
    'Chips' => %w(potatoes salt),
    'Crisps' => %w(potatoes salt),
  }

  def initialize(next_handler)
    @next_handler = next_handler
  end

  def handle(order)
    cooking_time = rand(5)
    sleep(cooking_time)

    ingredients = order.line_items.map do |uuid, line_item|
      INGREDIENTS[line_item['name']]
    end.flatten.uniq

    order.ingredients = ingredients
    order.cooking_time = cooking_time

    @next_handler.handle(order)
  end
end
