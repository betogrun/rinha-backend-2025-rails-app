# frozen_string_literal: true

class ProcessPayment
  def self.call(payment_processor, correlation_id, amount, requested_at)
    new(payment_processor, correlation_id, amount, requested_at).call
  end

  def initialize(payment_processor, correlation_id, amount, requested_at)
    @payment_processor = payment_processor
    @correlation_id = correlation_id
    @amount = amount
    @requested_at = requested_at
  end

  def call
    client = PaymentProcessor::Client.new(@payment_processor)

    client.payments.create(
      correlation_id: @correlation_id,
      amount: @amount,
      requested_at: @requested_at
    )

    Payment.create(
      processor: @payment_processor.to_s,
      correlation_id: @correlation_id,
      amount_cents: (@amount.to_f * 100).to_i,
      requested_at: Time.zone.parse(@requested_at)
    )
  end
end
