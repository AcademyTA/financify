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
    @user        = current_user
    @user_stocks = @user.stocks

    @user_stocks.each { |stock| stock.update(last_price: stock.price) }

    render partial: 'stocks/list'
  end
end
