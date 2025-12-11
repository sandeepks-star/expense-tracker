require 'csv'
require "debug"
require_relative 'ExpenseTracker.rb'

class Login

  def user_login
    run = ExpenseTracker.new
    puts "\n\n============================================"
    puts "\n\n--- Please enter Your Details to login -----"
    puts "\n\n============================================"
    puts "\n\nEnter Your Email"
    @email = gets.chomp
    $current_user = @email
    puts "\n\nEnter your Password"
    @password = gets.chomp
    user_found = false
    CSV.foreach("User_details.csv", "r", headers:true) do |row|
      user_hash = row.to_h
      if user_hash['email'] == @email && user_hash['password'] == @password
        user_found = true
        puts "\n\n=============================================="
        puts "------ Welcome to Personal Expense Tracker ------"
        puts "=================================================="
        puts "\nLogin Successful"
        puts "\nWelcome, #{@email}"
        run.run_tracker
      end
    end
    if user_found == false
        puts "\nInvalid credentials, please login again\n\n"
      end
  end
end