# frozen_string_literal: true

module PaymentProcessor
  class Selector
    def initialize
      @default_status = Rails.cache.read("default_payment_processor_health_status")
      @fallback_status = Rails.cache.read("fallback_payment_processor_health_status")
    end

    def select
      if !@default_status.failing? && !@fallback_status.failing?
        default_return = calculate_net_return(:default, @default_status.min_response_time)
        fallback_return = calculate_net_return(:fallback, @fallback_status.min_response_time)

        fallback_return > default_return ? Fallback.new : Default.new
      elsif !@default_status.failing? && @fallback_status.failing?
        Default.new
      elsif @default_status.failing? && !@fallback_status.failing?
        Fallback.new
      else
        None.new
      end
    end

    private

    def calculate_net_return(processor, response_time)
      performance_bonus = calculate_performance_bonus(response_time)
      fee = fees[processor]

      (1 - fee) * (1 + performance_bonus)
    end

    def calculate_performance_bonus(response_time)
      bonus = (11 - response_time) * 0.02
      [ bonus, 0 ].max
    end

    def fees
      {
        default: 0.05,
        fallback: 0.15
      }
    end
  end
end
