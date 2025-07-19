# frozen_string_literal: true

module PaymentProcessor
  module Entities
    class HealthStatus
      attr_reader :failing, :min_response_time

      def initialize(response)
        @failing = response["failing"]
        @min_response_time = response["minResponseTime"]
      end

      def failing?
        @failing
      end
    end
  end
end
