# frozen_string_literal: true

module PaymentProcessor
  class Default
    def to_sym
      :default
    end

    def to_s
      "default"
    end

    def none?
      false
    end
  end
end
