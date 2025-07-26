# frozen_string_literal: true

module Payments
  class SummariesController < ApplicationController
    def index
      summary = SummaryRetriever.new(permitted_params[:from], permitted_params[:to]).retrieve

      render json: SummarySerializer.new(summary).as_json, status: :ok
    end

    private

    def permitted_params
      params.permit(:from, :to)
    end
  end
end
