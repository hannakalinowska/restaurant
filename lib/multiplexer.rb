class Multiplexer
  def initialize(next_handlers)
    @next_handlers = next_handlers
  end

  def handle(order)
    @next_handlers.each do |handler|
      handler.handle(order.dup)
    end
  end
end
