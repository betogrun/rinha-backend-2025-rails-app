# frozen_string_literal: true

module PaymentProcessor
  module Entities
    class Payment
      attr_reader :correlation_id, :amount, :requested_at

      def initialize(response)
        @correlation_id = response["correlationId"]
        @amount = response["amount"]
        @requested_at = response["requestedAt"]
      end
    end
  end
end
