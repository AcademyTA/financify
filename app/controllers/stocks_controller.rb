class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock   = Stock.find_by_ticker(params[:stock].upcase)
      @stock ||= Stock.new_from_lookup(params[:stock])
    end

    if @stock
      render partial: 'lookup'
    else
      render status: :not_found, nothing: true
    end
  end
end
