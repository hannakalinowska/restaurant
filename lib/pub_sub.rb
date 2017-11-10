class PubSub
  def initialize
    @topics = {}
    @mutex = Mutex.new
  end

  def publish(message)
    topic = message.type

    @topics.fetch(topic, []).each { |handler| handler.handle(message) }
    @topics.fetch(message.correlation_id, []).each { |handler| handler.handle(message) }
  end

  def subscribe_to_correlation_id(correlation_id, handler)
    subscribe(correlation_id, handler)
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
