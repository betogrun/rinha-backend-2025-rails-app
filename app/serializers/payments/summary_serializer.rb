# frozen_string_literal: true

module Payments
  class SummarySerializer
    def initialize(summary)
      @summary = summary
    end

    def as_json(*)
      @summary.map do |item|
        [
          item.processor,
          {
            "totalRequests" => item.total_count,
            "totalAmount" => item.total_amount.to_f
          }
       ]
      end.to_h
    end
  end
end
