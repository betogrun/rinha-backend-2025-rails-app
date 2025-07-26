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

      error_message = "Request failed with status #{response.status}: #{response.body}"
      raise error_for_status(response.status), error_message
    end

    def error_for_status(status)
      case status
      when 400
        PaymentProcessor::ClientError::BadRequestError
      when 404
        PaymentProcessor::ClientError::NotFoundError
      when 422
        PaymentProcessor::ClientError::UnprocessableEntityError
      when 429
        PaymentProcessor::ClientError::TooManyRequestsError
      when 500
        PaymentProcessor::ServerError::InternalServerError
      when 502
        PaymentProcessor::ServerError::BadGatewayError
      when 503
        PaymentProcessor::ServerError::ServiceUnavailableError
      when 504
        PaymentProcessor::ServerError::GatewayTimeoutError
      when 400..499
        PaymentProcessor::ClientError
      when 500..599
        PaymentProcessor::ServerError
      else
        PaymentProcessor::Error
      end
    end
  end
end
