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

      def ==(other)
        return false unless other.is_a?(HealthStatus)

        @failing == other.failing && @min_response_time == other.min_response_time
      end
    end
  end
end
