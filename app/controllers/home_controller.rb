class HomeController < ApplicationController
  def home
    if user_signed_in?
      redirect_to transactions_path
    else
      redirect_to new_user_session_path
    end
  end

  def total
    @total1 = current_user.incomes.sum("amount")
    #@total1 = current_user.incomes.where('extract(month from trans_date) = ?', 6).sum("amount") #.select("SUM('amount') as total")
    @total2 = current_user.expenses.sum("amount")#.where"MONTH(date_column) = 12"
  end
end
