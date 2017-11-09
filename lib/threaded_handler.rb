class ThreadedHandler
  attr_reader :name, :type

  def self.wrap(handler)
    new(handler).tap { |wrapped| registry << wrapped }
  end

  def self.registry
    @registry ||= []
  end

  def self.start_all
    registry.map(&:start)
  end

  def initialize(handler)
    @name = handler.name
    @type = handler.class.name.underscore.humanize
    @queue = Queue.new
    @handler = handler
  end

  def queue_size
    @queue.size
  end

  def handle(order)
    @queue.push(order)
  end

  def start
    Thread.new do
      loop do
        order = @queue.pop
        @handler.handle(order)
      end
    end
  end
end
