require 'date'

class Expense
  attr_accessor :date, :category, :amount, :notes
  def initialize(date, category, amount, notes)
    @date = date || Date.today
    @category = category
    @amount = amount
    @notes = notes
  end

  def display_category_wise
    puts "Date: [#{@date}], Category: #{@category}"
  end

  def display
    puts "Date: [#{@date}], Category: #{@category}, Amount: #{@amount}, Notes: #{@notes}"
  end
end