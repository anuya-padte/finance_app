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

    @try = Category.joins(:transactions)
                   .select("categories.name AS c_name,
                            count(transactions.id) AS count,
                            max(transactions.amount) as max,
                            min(transactions.amount) as min,
                            avg(transactions.amount) as avg ")
                   .group("categories.name")
                   .where("transactions.user_id = #{current_user.id}")

  end
end
