require 'rainbow'
require 'faker'

class Cook
  attr_reader :name, :cooking_time

  def initialize(bus)
    @bus = bus
    @name = Faker::Name.first_name
    @cooking_time = rand
  end

  def handle(order)
    puts Rainbow("#{@name} is cooking #{order.number} for #{(cooking_time * 1000).round}ms").bright.orange
    sleep(cooking_time)

    ingredients = order.line_items.map do |uuid, line_item|
      (rand(3) + 1).times.map { Faker::Food.ingredient }
    end.flatten.uniq

    order.cook = @name
    order.ingredients = ingredients
    order.cooking_time = cooking_time

    @bus.publish('order_cooked', order.dup)
  end
end
