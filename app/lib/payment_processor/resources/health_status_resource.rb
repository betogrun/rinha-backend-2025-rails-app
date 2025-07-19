# frozen_string_literal: true

module PaymentProcessor
  module Resources
    class HealthStatusResource < PaymentProcessor::Resource
      def check
        response = get_request("/payments/service-health")

        Entities::HealthStatus.new(response)
      end
    end
  end
end
