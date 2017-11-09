require 'faker'

class Cook
  def initialize(next_handler)
    @next_handler = next_handler
    @name = Faker::Name.first_name
  end

  def handle(order)
    cooking_time = rand
    puts "#{@name} is cooking #{order.number} for #{(cooking_time * 1000).round}ms"
    sleep(cooking_time)

    ingredients = order.line_items.map do |uuid, line_item|
      (rand(3) + 1).times.map { Faker::Food.ingredient }
    end.flatten.uniq

    order.cook = @name
    order.ingredients = ingredients
    order.cooking_time = cooking_time

    @next_handler.handle(order.dup)
  end
end
