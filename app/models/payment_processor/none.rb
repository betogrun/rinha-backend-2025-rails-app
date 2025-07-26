# frozen_string_literal: true

module PaymentProcessor
  class None
    def to_sym
      :none
    end

    def to_s
      "none"
    end

    def none?
      true
    end
  end
end
