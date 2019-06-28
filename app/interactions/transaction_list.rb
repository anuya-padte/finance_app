class TransactionList < ActiveInteraction::Base
  attr_reader :total, :search

  string :type, default:"Transaction"
  hash :search,  default: nil do
    string :date_from, default:nil
    string :date_to, default:nil
  end
  
  def execute
    @searchT = TransactionSearch.new(search)
    @all = @searchT.scope.where(user_id: 1)
    unless type == "Transaction"
      @all = @all.where(type: type) 
      @total = @all.where(type: type).sum("amount")
    end
    return @all , @total, @searchT
  end
end