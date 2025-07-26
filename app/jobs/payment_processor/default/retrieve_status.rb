# frozen_string_literal: true

module PaymentProcessor
  class Default
    class RetrieveStatus < ApplicationJob
      queue_as :default

      retry_on PaymentProcessor::ClientError::TooManyRequestsError, wait: :exponentially_longer, attempts: 3
      retry_on PaymentProcessor::Error, wait: 2.seconds, attempts: 2

      def perform(*args, **kwargs)
        client = PaymentProcessor::Client.new(PaymentProcessor::Default.new)
        status = client.health_status.check

        Rails.cache.write("default_payment_processor_health_status", status) if status != current_status
        PaymentProcessor::Default::RetrieveStatus.perform_later(wait: 6.seconds) unless should_stop?
      end

      private

      def current_status
        Rails.cache.read("default_payment_processor_health_status")
      end

      def should_stop?
        Rails.cache.read("default_payment_processor_health_status_stop") == true
      end
    end
  end
end
