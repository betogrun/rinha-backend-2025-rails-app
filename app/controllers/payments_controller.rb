# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :start_status_retrievers_once, only: [ :create ]

  def create
    requested_at = Time.zone.now.iso8601
    ProcessPaymentJob.
      perform_later(payment_params[:correlation_id], payment_params[:amount], requested_at)

    render json: { message: "Payment creation initiated" }, status: :accepted
  end

  private

  def payment_params
    {
      correlation_id: params[:correlationId],
      amount: params[:amount]
    }
  end

  def start_status_retrievers_once
    Rails.cache.fetch("status_retrievers_started", expires_in: 24.hours) do
      PaymentProcessor::Default::RetrieveStatus.perform_later
      PaymentProcessor::Fallback::RetrieveStatus.perform_later
      true
    end
  end
end
