class PubSub
  def initialize
    @topics = {}
    @mutex = Mutex.new
    @log = File.open(Bundler.root.join('history.log'), 'a+')
  end

  def close
    @log.close
  end

  def publish(message)
    topic = message.type
    @log.syswrite(message.order.to_json + $RS)
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
