class UserStocksController < ApplicationController

  def create
    @user_stock =
      if params[:stock_id].present?
        UserStock.new(user: current_user, stock_id: params[:stock_id])
      else
        stock = create_stock
        UserStock.new(user: current_user, stock: stock)
      end

    if @user_stock.save
      flash[:notice] = "Stock #{@user_stock.stock.ticker} was successfully added"
      redirect_to my_portfolio_path
    else
      flash[:alert] = "Something went wrong. #{@user_stock.errors.inspect}"
      redirect_to my_portfolio_path
    end
  end

  def destroy
    @user_stock = UserStock.find_by(stock_id: params[:id])

    if @user_stock.destroy
      flash[:notice] = 'Stock was successfully removed from portfolio.'
      redirect_to my_portfolio_path
    else
      flash[:alert] = 'Unable to remove stock from portfolio.'
      redirect_to my_portfolio_path
    end
  end

  private

  def user_stock_params
    params.require(:user_stock).permit(:user_id, :stock_id)
  end

  def create_stock
    Stock.create(
      ticker: params[:stock_ticker],
      name: params[:stock_name],
      last_price: BigDecimal.new(params[:stock_price])
    )
  end
end
