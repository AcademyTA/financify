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

  def update_stocks_prices
    @stocks = current_user.stocks

    @stocks.each { |stock| stock.update(last_price: stock.price) }

    flash[:notice] = 'Stocks Updated'
    redirect_to my_portfolio_path
  end
end
