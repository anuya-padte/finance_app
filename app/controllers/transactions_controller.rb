class TransactionsController < ApplicationController
  include Pagy::Backend

  before_action :logged_in_user
  before_action :correct_user,    only: [:show, :edit, :update, :destroy]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_type

  def index
    para = {}
    if !params[:search].nil?
      para[:date_from] = params[:search][:date_from]
      para[:date_to] = params[:search][:date_to]
    end
    @all, @total, @search = TransactionList.run(type: type, search: para).result
    @pagy, @invoices = pagy(@all, items:5)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Statement.new(@search, @all, view_context)
        send_data pdf.render, filename: "statement_#{Time.now.strftime('%Y-%m-%d_%H-%M-%S')}",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def show  
  end

  def new
    @transaction = type_class.new
    @categories = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: type)
  end

  def create
    @transaction = current_user.transactions.build(tran_params)
    if @transaction.save
      flash[:success] = "Transaction created!"
      redirect_to transaction_path @transaction
    else
      flash[:warning] = "Transaction not created!"
      render action: 'new'
    end
  end

  def edit
    @categories = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: type)
  end
  
  def update
    if @transaction.update_attributes(tran_params)
      flash[:success] = "Transaction updated successfully"
      redirect_to @transaction
    else
      render action: 'edit'
    end
  end

  def destroy
    @transaction.destroy
    flash[:success] = "Transaction deleted"
    redirect_to root_url
  end

  private #------------------------------PRIVATE METHODS----------------------------------

  def tran_params
    params.require(type.underscore.to_sym).permit(:type, :trans_date, :amount, :description, :category_id)
  end

  def correct_user
    @transaction = current_user.transactions.find_by(id: params[:id])
    redirect_to root_url if @transaction.nil?
  end

  def set_transaction
    @transaction = type_class.find(params[:id])
  end

  def set_type 
    @type = type 
  end

  def type 
    Transaction.types.include?(params[:type]) ? params[:type] : "Transaction"
  end

  def type_class 
    type.constantize 
  end

end
