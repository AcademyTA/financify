class Stock < ActiveRecord::Base
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
    find_by(ticker: ticker_symbol)
  end

  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)

    return nil unless looked_up_stock.name

    new_stock = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_stock.last_price = new_stock.price
    new_stock
  end

  def price
    stock = StockQuote::Stock.quote(ticker)

    if stock.response_code == 200
      closing_price = stock.close
      return "#{closing_price} (Closing)" if closing_price

      opening_price = stock.open
      return "#{opening_price} (Opening)" if opening_price
    else
      'Unavailable'
    end
  end

  def update_time
    updated_at.in_time_zone.strftime("%B %e, %Y at %l:%M%P %Z")
  end
end
