# frozen_string_literal: true

module PaymentProcessor
  module Resources
    class PaymentResource < PaymentProcessor::Resource
      def create(correlation_id:, amount:, requested_at:)
        body = {
          correlationId: correlation_id,
          amount: amount,
          requestedAt: requested_at
        }
        response = post_request("/payments", body: body)

        Entities::Payment::Response.new(response)
      end

      def find(correlation_id:)
        response = get_request("/payments/#{correlation_id}")

        Entities::Payment.new(response)
      end
    end
  end
end
