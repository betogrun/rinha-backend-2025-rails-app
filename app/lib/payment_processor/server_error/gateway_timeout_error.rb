# frozen_string_literal: true

module PaymentProcessor
  class ServerError
    class GatewayTimeoutError < ServerError; end
  end
end
