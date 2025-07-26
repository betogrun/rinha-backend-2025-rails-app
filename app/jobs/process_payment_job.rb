# frozen_string_literal: true

class ProcessPaymentJob < ApplicationJob
  queue_as :default
  retry_on PaymentProcessor::Error, wait: 2.seconds, attempts: 3

  def perform(correlation_id, amount, requested_at)
    payment_processor = PaymentProcessor::Selector.new.select
    if payment_processor.none?
      ProcessPaymentJob.perform_later(correlation_id, amount, requested_at)
    else
      ProcessPayment.call(payment_processor, correlation_id, amount, requested_at)
    end
  end
end
