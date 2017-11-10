require 'securerandom'

class Message
  attr_accessor :message_id, :correlation_id, :causation_id, :type, :publish_at
  attr_reader :payload

  def initialize(type, payload)
    @message_id = SecureRandom.uuid[0 .. 7]
    @type = type
    @payload = payload.dup
  end

  def reply(type, payload = nil)
    Message.new(type, payload || @payload).tap do |message|
      message.type = type
      message.causation_id = self.message_id
      message.correlation_id = self.correlation_id
    end
  end

  def delayed_reply(type, seconds)
    message = self.reply(type)
    Message.new('schedule_message', message).tap do |m|
      m.publish_at = Time.now + seconds
      m.causation_id = self.message_id
      m.correlation_id = self.correlation_id
    end
  end

  def to_json(*a)
    {
      id: message_id,
      causation_id: causation_id,
      correlation_id: correlation_id,
      type: type,
      payload: @payload,
      publish_at: publish_at,
    }.to_json
  end
end
