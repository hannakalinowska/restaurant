class PubSub
  def initialize
    @topics = Hash.new { |h, k| h[k] = [] }
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

  def subscribe(*subscribed_topics, handler)
    @mutex.synchronize do
      topics = @topics.dup
      subscribed_topics.each { |t| topics[t].push(handler) }
      @topics = topics
    end
  end

  def unsubscribe(handler)
    @mutex.synchronize do
      @topics.each do |topic, handlers|
        handlers.delete(handler)
      end
    end
  end
end
