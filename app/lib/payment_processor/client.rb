# frozen_string_literal: true

module PaymentProcessor
  class Client
    DEFAULT_URL = "http://payment-processor-default:8080"
    FALLBACK_URL = "http://payment-processor-fallback:8080"

    def initialize(processor = :default, adapter = Faraday.default_adapter)
      @processor = processor
      @adapter = adapter
    end

    def payments
      Resources::PaymentResource.new(connection)
    end

    def health_status
      Resources::HealthStatusResource.new(connection)
    end

    private

    def connection
      @connection ||= Faraday.new(url: processors[@processor]) do |conn|
        conn.adapter @adapter
        conn.headers["Content-Type"] = "application/json"
        conn.headers["Accept"] = "application/json"
        conn.response :json, content_type: /\bjson$/
      end
    end

    def processors
      { default: DEFAULT_URL, fallback: FALLBACK_URL }
    end
  end
end
