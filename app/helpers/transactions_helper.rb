module TransactionsHelper
  def sti_transaction_path(type = "transaction", transaction = nil, action = nil)
    send "#{format_sti(action, type, transaction)}_path", transaction
  end
  
  def format_sti(action, type, transaction)
    action || transaction ? "#{format_action(action)}#{type.underscore}" : "#{type.underscore.pluralize}"
  end
  
  def format_action(action)
    action ? "#{action}_" : ""
  end
end
