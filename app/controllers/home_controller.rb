class HomeController < ApplicationController
  def home
    if user_signed_in?
      redirect_to transactions_path
    else
      redirect_to new_user_session_path
    end
  end

  def summary
    # @total1 = current_user.incomes.sum("amount")
    # @total2 = current_user.expenses.sum("amount")

    @try = Category.joins(:transactions)
                   .select("categories.name AS c_name,
                            categories.cat_type AS c_type,
                            count(transactions.id) AS count,
                            max(transactions.amount) as max,
                            min(transactions.amount) as min,
                            avg(transactions.amount) as avg ")
                   .group("categories.name")
                   .where("transactions.user_id = #{current_user.id}")

  end


end
