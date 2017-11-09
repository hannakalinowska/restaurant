class PubSub
  def initialize
    @topics = {}
    @mutex = Mutex.new
  end

  def publish(topic, order)
    @topics[topic].each { |handler| handler.handle(order) }
  end

  def subscribe(topic, handler)
    @mutex.synchronize do
      topics = @topics.dup
      topics[topic] ||= []
      topics[topic].push(handler)
      @topics = topics
    end
  end
end
