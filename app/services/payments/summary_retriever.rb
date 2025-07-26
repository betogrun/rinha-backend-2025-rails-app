# frozen_string_literal: true

module Payments
  class SummaryRetriever
    def initialize(from, to)
      @from = Time.zone.parse(from)
      @to = Time.zone.parse(to)
    end

    def retrieve
      Payment.
        where(requested_at: @from..@to).
        select("processor, SUM(amount_cents) / 100.0 AS total_amount, COUNT(*) AS total_count").
        group(:processor).
        order(:processor)
    end
  end
end
