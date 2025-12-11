require_relative 'Expense.rb'
require_relative 'Login.rb'
require 'csv'
require 'date'

module ExpenseValidator
  CATEGORIES = "Food, Travel, Shopping"
  def amount_validator
    puts "\n\n----- Add Amount of Expense -----"
    @amount = gets.chomp
    for a in 1..3 do
      return if @amount.to_f > 0
      puts "Please enter correct amount."
      @amount = gets.chomp
    end
  end

  def date_validator
    loop do
      puts "Expense Date (DD-MM-YYYY) or leave blank for todays date:"
      input_date = gets.chomp
      return if input_date.empty?
      begin
        @final_date = Date.strptime(input_date,"%d/%m/%Y")# && Date.strptime(input_date, "%d/%m/%Y")
        break
      rescue ArgumentError => e
        puts "Invalid date Format (DD-MM-YYYY)"
      end
    end
  end

  def category_validator
    puts "\n\n----- Choose from category #{CATEGORIES} -----"
    user_input = gets.chomp
    @category = user_input.capitalize

    for a in 1..3 do
      break if CATEGORIES.include?(@category)
      puts "Invalid selection choose from category #{CATEGORIES}"
      user_input = gets.chomp
      @category = user_input.capitalize!
    end
  end
end

class ExpenseTracker
  include ExpenseValidator

  def run_tracker
    loop do
      puts "\n\n Choose from below options \n"
      puts "1. Add Expense"
      puts "2. List Expense"
      puts "3. Show Summary"
      puts "4. Logout\n"
      choice = gets.chomp.to_i
      puts "\n"
      case choice
        when 1
          add_expense
        when 2
          list_expense
        when 3
          show_summary
        when 4
          puts "Logout Successfull, Thank you come again\n\n"
          return
      end
    end
  end

  def add_expense
    puts "\n\n----- Add your Expense -----"
    date_validator
    category_validator
    amount_validator
    puts "\n\n----- Add Notes (optional) -----"
    @notes = gets.chomp
    expense = Expense.new(@final_date,@category,@amount,@notes)
    expense_array = [expense.date, expense.category, expense.amount, expense.notes]
    CSV.open("#{$current_user}.csv", "a") do |csv|
      csv << expense_array
    end
    puts "\n ---- Expense added Successfully ----\n"
  end

  def list_expense
    count = 0
    CSV.foreach("#{$current_user}.csv", headers:true) do |row|
        puts " #{count+1}. -- #{row['date']} || #{row['category']} --\n"
        count = count + 1
    end
    if count == 0
      puts "No expense to show."
      return
    end
  end

  def show_summary
    puts "\nYour Expenses"
    list_expense
    puts "\n\nChoose the category to show expense category wise."
    user_choice = gets.chomp.downcase
    count = 0
      CSV.foreach("#{$current_user}.csv", "r" ,headers:true) do |row|
        if row['category'].downcase == user_choice
          count = count + 1
          puts "#{count}. Date: #{row['date']} | Category: #{row['category']} | Amount: #{row['amount']} | Notes: #{row['notes']}"
        end
      end
      if count == 0
        puts "No expenses found with category #{user_choice}, please try again"
      end
  end
end