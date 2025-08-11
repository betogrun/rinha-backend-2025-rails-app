# frozen_string_literal: true

module Payments
  class SummarySerializer
    def initialize(summary)
      @summary = Array(summary)
    end

    def as_json(*)
      result = {
        "default" => { "totalRequests" => 0, "totalAmount" => 0.0 },
        "fallback" => { "totalRequests" => 0, "totalAmount" => 0.0 }
      }

      @summary.each do |item|
        key = item.processor.to_s
        next unless result.key?(key)

        result[key]["totalRequests"] = item.total_count.to_i
        result[key]["totalAmount"] = item.total_amount.to_f
      end

      result
    end
  end
end
