class FairyDispatcher
  def initialize(next_handlers)
    @next_handlers = next_handlers
  end

  def handle(order)
    loop do
      @next_handlers.each do |handler|
        if handler.queue_size < 5
          handler.handle(order.dup)
          return
        end
      end
      sleep 0.1
    end
  end
end
