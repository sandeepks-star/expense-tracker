require 'csv'
require "debug"
require_relative 'ExpenseTracker.rb'

class Login

  def run_tracker
    expense = ExpenseTracker.new

    puts "\n\n Choose from below options "
    puts "1. Add Expense"
    puts "2. List Expense"
    puts "3. Show Summary"
    puts "4. Exit"

    choice = gets.chomp.to_i

    case choice
      when 1
        expense.add_expense
      when 2
        expense.list_expense
      when 3
        expense.show_summary
      when 4
        puts "Thank you come again"
        return
    end
  end

  def user_login
    puts "\n\n============================================"
    puts "\n\n--- Please enter Your Details to login -----"
    puts "\n\n============================================"

    puts "\n\nEnter Your Email"
    email = gets.chomp

    puts "\n\nEnter your Password"
    password = gets.chomp

    CSV.foreach("User_details.csv", "r", headers:true) do |row|
      if row.fields.include?(email) && row.fields.include?(password)
        puts "\n\n=============================================="
        puts "------ Welcome to Personal Expense Tracker ------"
        puts "=================================================="
        puts "\nLogin Successful"
        puts "\nWelcome, #{email}"
        run_tracker
      else
        puts "\nInvalid credentials, please login again\n\n"
      end
    end
  end
end