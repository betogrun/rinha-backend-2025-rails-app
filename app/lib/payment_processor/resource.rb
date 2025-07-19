# frozen_string_literal: true

module PaymentProcessor
  class Resource
    def initialize(connection)
      @connection = connection
    end

    def get_request(path, params: {}, headers: {})
      handle_response(@connection.get(path, params, headers))
    end

    def post_request(path, body: {}, headers: {})
      handle_response(@connection.post(path, body.to_json, headers))
    end

    private

    def handle_response(response)
      return response.body if response.success?

      raise PaymentProcessors::Error, "Request failed with status #{response.status}: #{response.body}"
    end
  end
end
