# frozen_string_literal: true

module PaymentProcessor
  class ClientError
    class UnprocessableEntityError < ClientError; end
  end
end
