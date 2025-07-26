# frozen_string_literal: true

module PaymentProcessor
  class Fallback
    class RetrieveStatus < ApplicationJob
      queue_as :default

      retry_on PaymentProcessor::ClientError::TooManyRequestsError, wait: :exponentially_longer, attempts: 3
      retry_on PaymentProcessor::Error, wait: 2.seconds, attempts: 2

      def perform(*args, **kwargs)
        client = PaymentProcessor::Client.new(PaymentProcessor::Fallback.new)
        status = client.health_status.check

        Rails.cache.write("fallback_payment_processor_health_status", status) if status != current_status
        PaymentProcessor::Fallback::RetrieveStatus.perform_in(6.seconds) unless should_stop?
      end

      private

      def should_stop?
        Rails.cache.read("fallback_payment_processor_health_status_stop") == true
      end

      def current_status
        Rails.cache.read("fallback_payment_processor_health_status")
      end
    end
  end
end
