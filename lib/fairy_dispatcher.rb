class FairyDispatcher
  def initialize(next_handlers)
    @next_handlers = next_handlers
  end

  def handle(order)
    loop do
      handler = @next_handlers.min_by(&:queue_size)
      if handler.queue_size < 5
        handler.handle(order.dup)
        return
      else
        sleep 0.1
      end
    end
  end
end
