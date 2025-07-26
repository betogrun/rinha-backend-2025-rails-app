# frozen_string_literal: true

module PaymentProcessor
  class ServerError
    class BadGatewayError < ServerError; end
  end
end
