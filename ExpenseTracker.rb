require_relative 'Expense.rb'
# require_relative 'Login.rb'
require 'date'

class ExpenseTracker

  def add_amount
    puts "\n\n----- Add Amount of Expense -----"
    @amount = gets.chomp
    for a in 1..3 do
      return if @amount.to_f > 0
      puts "Please enter correct amount."
      @amount = gets.chomp
    end
  end

  def choose_date

    # user_date = gets.chomp

    # final_date = user_date.empty? ? Date.today : Date.parse(user_date)

    loop do
      puts "Expense Date (YYYY-MM-DD) or leave blank for todays date:"
      input_date = gets.chomp
      return if input_date.empty?

      begin
        @final_date = Date.strptime(input_date,"%y/%m/%d")# && Date.strptime(input_date, "%d/%m/%Y")
        break
      rescue ArgumentError => e
        puts "Invalid date Format (YYYY-MM-DD)"
      end
    end

  end

  def choose_category
    arr = ["Food", "Travel", "Shopping"]
    puts "\n\n----- Choose from category #{arr.join(",")} -----"

    user_input = gets.chomp
    @category = user_input.capitalize!

    for a in 1..3 do
      break if arr.include?(@category)
      puts "Invalid selection choose from category #{arr.join(",")}"
      user_input = gets.chomp
      @category = user_input.capitalize!
    end
  end

  def summary
    puts "\n\nChoose the expense to show"
    loop do
      index = gets.chomp.to_i - 1
      if index>=0 && index<=@expenses.length
        print "\n#{index+1} "
        @expenses[index].display
        break
      else
        puts "Invalid selection, please choose from options available"
      end
    end
  end

  def add_expense

    puts "\n\n----- Add your Expense -----"

    choose_date

    choose_category

    add_amount

    puts "\n\n----- Add Notes (optional) -----"
    notes = gets.chomp

    expense = Expense.new(final_date,category,amount,notes)
    expense_array = [expense.date, expense.category, expense.amount, expense.notes]

    CSV.open("#{user_email}.csv", "a") do |csv|
      csv << expense_array
    end

    puts "\n ---- Expense added Successfully ----\n"
  end

  def list_expense
    return puts "\n No Expense to Show" if @expenses.empty?
    
      puts "\n\n Your Expenses Date and Category Wise"
      @expenses.each_with_index do |exp_item, index|
        print "\n#{index + 1}. "
        exp_item.display_category_wise
      end
  end

  def show_summary
    puts "\nYour Expenses"
    list_expense
    return if @expenses.empty?
    summary
  end

end