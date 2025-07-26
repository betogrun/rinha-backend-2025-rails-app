# frozen_string_literal: true

module PaymentProcessor
  class ClientError
    class TooManyRequestsError < ClientError; end
  end
end
