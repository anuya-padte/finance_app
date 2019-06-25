class SummaryPdf < Prawn::Document
  include ApplicationHelper
  def initialize(category, transactions, total, view)
    super(top_margin: 50)
    @category = category
    @transactions = transactions
    @total = total
    @view = view
    summary_title
    line_items
    total_price
  end

  def summary_title
    text "#{@category.name} summary" , size:30, style: :bold
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      column(1).align = :right
      self.row_colors = ["DDDDDD","FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Date", "Amount", "Description"]]+
    @transactions.map do |i|
      [i.trans_date, number_to_indian_currency(i.amount), i.description]
    end
  end

  def price(num)
    @view.number_to_currency(num)
  end

  def total_price
    move_down 20
    text "Total #{@category.cat_type} in Category #{@category.name}: #{@total}" , size: 16, font: :bold 
  end
end