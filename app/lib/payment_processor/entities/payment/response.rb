# frozen_string_literal: true

module PaymentProcessor
  module Entities
    class Payment
      class Response
        attr_reader :message

        def initialize(response)
          @message = response["message"]
        end
      end
    end
  end
end
