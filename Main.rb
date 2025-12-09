require_relative 'Login.rb'
require_relative 'Registration.rb'

class Main
  def run
    register = Registration.new
    #expense = ExpenseTracker.new
    loop do
      puts "=============================================="
      puts "-----Welcome to Personal Expense Tracker -----"
      puts "=============================================="
      # puts "\n\n Choose from below options "
      # puts "1. Add Expense"
      # puts "2. List Expense"
      # puts "3. Show Summary"
      # puts "4. Exit"

      # choice = gets.chomp.to_i

      # case choice
      # when 1
      #   expense.add_expense
      # when 2
      #   expense.list_expense
      # when 3
      #   expense.show_summary
      # when 4
      #   puts "Exited Successfully"
      #   return
      # end

      puts "\n-----Choose from below options-----"
      puts "\n 1. Login "
      puts "\n 2. Register"
      puts "\n 3. Exit\n\n"

      choice = gets.chomp.to_i

      case choice
      when 1
        Login
      when 2
        register.registration_details
      when 3
        puts "Exited Successfully"
        break
      end

    end
  end
end

start = Main.new
start.run