# frozen_string_literal: true

module PaymentProcessor
  class ServerError
    class ServiceUnavailableError < ServerError; end
  end
end
