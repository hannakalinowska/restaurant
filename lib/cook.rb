require 'faker'

class Cook
  def initialize(next_handler)
    @next_handler = next_handler
    @name = Faker::Name.first_name
  end

  def handle(order)
    cooking_time = 0.5
    sleep(cooking_time)

    ingredients = order.line_items.map do |uuid, line_item|
      (rand(3) + 1).times.map { Faker::Food.ingredient }
    end.flatten.uniq

    order.cook = @name
    order.ingredients = ingredients
    order.cooking_time = cooking_time

    @next_handler.handle(order)
  end
end
