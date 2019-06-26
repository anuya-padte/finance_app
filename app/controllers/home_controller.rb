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
                            categories.id AS cid,
                            categories.cat_type AS c_type,
                            count(transactions.id) AS count,
                            max(transactions.amount) as max,
                            min(transactions.amount) as min,
                            avg(transactions.amount) as avg ")
                   .group("categories.name")
                   .where(transactions: {user_id: current_user.id})

  end

  def detail
    @category = Category.find(params[:id])
    @transactions = current_user.transactions.where(category_id: @category.id)
    @total = current_user.transactions.where(category_id: @category.id).sum("amount")
    respond_to do |format|
      format.html
      format.pdf do
        pdf = SummaryPdf.new(@category, @transactions, @total, view_context)
        send_data pdf.render, filename: "#{@category.name}_summary",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
end
