require_relative 'expense.rb'
require_relative 'login.rb'
require_relative 'expense_validator.rb'
require 'csv'
require 'date'



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

  private def call_expensevalidator
    date_validator
    category_validator
    amount_validator
  end

  def add_expense
    puts "\n\n----- Add your Expense -----"
    call_expensevalidator
    puts "\n\n----- Add Notes (optional) -----"
    @notes = gets.chomp

    expense = Expense.new(@final_date,@category,@amount,@notes)

    expense_details = expense.expense_array

    CSV.open("#{$current_user}.csv", "a") do |csv|
      csv << expense_details
    end
    puts "\n ---- Expense added Successfully ----\n"
  end

  private def list_expense
    count = 0
    CSV.foreach("#{$current_user}.csv", headers:true) do |row|
        puts " #{count+1}. -- #{row['date']} || #{row['category']} --\n"
        count = count + 1
    end
    return puts "No expense to show." if count == 0
  end

  private def show_summary
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
    return puts "No expenses found with category #{user_choice}, please try again" if count == 0
  end
end