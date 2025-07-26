# frozen_string_literal: true

Rails.application.config.after_initialize do
  PaymentProcessor::Default::RetrieveStatus.perform_later
  PaymentProcessor::Fallback::RetrieveStatus.perform_later
end
