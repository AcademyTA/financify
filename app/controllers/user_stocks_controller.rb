class UserStocksController < ApplicationController

  def create
    if params[:stock_id].present?
      @user_stock = UserStock.new(stock_id: params[:stock_id], user: current_user)
    else
      stock = Stock.find_by_ticker(params[:stock_ticker])

      if stock
        @user_stock = UserStock.new(user: current_user, stock: stock)
      else
        stock = Stock.new_from_lookup(params[:stock_ticker])

        if stock.save
          @user_stock = UserStock.new(user: current_user, stock: stock)
        else
          @user_stock = nil
          flash[:alert] = 'Stock is not available'
        end
      end
    end

    if @user_stock.save
      redirect_to my_portfolio_path
      flash[:notice] = "Stock #{@user_stock.stock.ticker} was successfully added"
    else
      redirect_to my_portfolio_path
      flash[:alert] = "Something went wrong. #{@user_stock.errors.inspect}"
    end
  end

  def destroy
    @user_stock = UserStock.find_by(stock_id: params[:id])

    if @user_stock.destroy
      redirect_to my_portfolio_path
      flash[:alert] = 'Stock was successfully removed from portfolio.'
    else
      redirect_to my_portfolio_path
      flash[:alert] = 'Unable to remove stock from portfolio.'
    end
  end

  private

  def user_stock_params
    params.require(:user_stock).permit(:user_id, :stock_id)
  end
end
