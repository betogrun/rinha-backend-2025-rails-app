# frozen_string_literal: true

module PaymentProcessor
  class Fallback
    def to_sym
      :fallback
    end

    def to_s
      "fallback"
    end

    def none?
      false
    end
  end
end
