class RoundRobinDispatcher
  def initialize(next_handlers)
    @next_handlers = Queue.new
    next_handlers.each { |handler| @next_handlers.push(handler) }
  end

  def handle(order)
    handler = @next_handlers.pop
    begin
      handler.handle(order.dup)
    rescue
      # it's fine
    ensure
      @next_handlers.push(handler)
    end
  end
end
