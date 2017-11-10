require 'securerandom'

class Message
  attr_accessor :message_id, :correlation_id, :causation_id, :type
  attr_reader :order

  def initialize(type, order)
    @message_id = SecureRandom.uuid[0 .. 7]
    @type = type
    @order = order.dup
  end

  def reply(type, order = nil)
    Message.new(type, order || @order).tap do |message|
      message.type = type
      message.causation_id = self.message_id
      message.correlation_id = self.correlation_id
    end
  end
end
