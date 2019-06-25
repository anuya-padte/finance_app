class Statement < Prawn::Document
  include ApplicationHelper
  def initialize(search, invoices, view)
    super(top_margin: 50)
    @search = search
    @invoices = invoices
    @view = view
    summary_title
    line_items
  end

  def summary_title
    text "Statement for all Transactions", size:25
    text "From #{@search.date_from} to #{@search.date_to}" , size:20, style: :bold
  end

  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      column(3).align = :right
      self.row_colors = ["DDDDDD","FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Date", "Type", "Category", "Amount", "Description"]]+
    @invoices.map do |i|
      [i.trans_date, i.type, i.category.name, number_to_indian_currency(i.amount), i.description]
    end
  end
end