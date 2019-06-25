module ApplicationHelper
  include Pagy::Frontend

  def number_to_indian_currency(number)
    if number.present?
      string = number.to_s.split('.')
      number = string[0].gsub(/(\d+)(\d{3})$/){ p = $2;"#{$1.reverse.gsub(/(\d{2})/,'\1,').reverse},#{p}"}
      number = number.gsub(/^,/, '') + '.' + string[1] if string[1] # remove leading comma
      number = number[1..-1] if number[0] == 44
    end
    "Rs. #{number}"
   end
end
