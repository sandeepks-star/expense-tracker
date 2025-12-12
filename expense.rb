require 'date'

class Expense
  attr_accessor :date, :category, :amount, :notes
  def initialize(date, category, amount, notes)
    @date = date || Date.today
    @category = category
    @amount = amount
    @notes = notes
  end

  def expense_array
    e_array = [date, category, amount, notes]
  end
end