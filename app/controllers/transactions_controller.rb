class TransactionsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,    only: [:show, :edit, :update, :destroy]
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  before_action :set_type

  def index
    #all
    @transactions = type_class.all.where(user_id: current_user.id)
    @total = type_class.where(user_id: current_user.id).sum("amount")
  end

  def show
    p "Reached show"
    @income = Transaction.find(params[:id])
  end

  def new
    @transaction = type_class.new
    @categories = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: "#{type_class}")
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
    @transaction = Transaction.find(params[:id])
    @categories = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: "#{type_class}")
  end
  
  def update
    @transaction = Transaction.find(params[:id])
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
