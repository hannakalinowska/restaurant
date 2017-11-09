class ThreadedHandler
  def initialize(next_handler)
    @queue = Queue.new
    @next_handler = next_handler
  end

  def handle(order)
    @queue.push(order)
  end

  def start
    Thread.new do
      loop do
        order = @queue.pop
        @next_handler.handle(order)
      end
    end
  end
end
