class CategoriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @category = current_user.categories.build(cat_params)
    if @category.save
      flash[:success] = "Category created!"
      redirect_to '/help'
    else
      @feed_items = []
      render 'transactions/index'
    end
  end

  def destroy
    @category.destroy
    flash[:success] = "category deleted"
    redirect_to root_url
  end

  def add_category
    @category  = current_user.categories.build
    @feed_items = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: "Income")
    @feed_item2 = Category.where(user_id: nil).or(Category.where(user_id: current_user.id)).where(cat_type: "Expense")
  end

  private

  def cat_params
    params.require(:category).permit(:name, :cat_type)
  end

  def correct_user
    @category = current_user.categories.find_by(id: params[:id])
    redirect_to root_url if @category.nil?
  end
end
