require 'csv'
require_relative 'User_details.rb'

class Registration
  @user_headers = ["Name", "Last Name", "Email", "Password", "Age", "City", "Occupation"]

  def registration_details
    puts "\n\n==>> Enter your details to Register <<=="

    puts "\n\nEnter you name::"
    @name = gets.chomp

    puts "\n\nEnter your Last Name::"
    @last_name = gets.chomp

    puts "\n\nEnter your Email::"
    @email = gets.chomp

    puts "\n\nCreate Password::"
    @password = gets.chomp

    puts "\n\nEnter your Age::"
    @age = gets.chomp.to_i

    puts "\n\nEnter your City::"
    @city = gets.chomp

    puts "\n\nEnter you Occupation::"
    @occupation = gets.chomp

    unless File.exist?('User_details.csv') && !File.zero?('User_details.csv')
      CSV.open("User_details.csv", "w") do |csv|
        csv << @user_headers
      end
    end

    CSV.open("User_details.csv", "a") do |csv|

      csv << [@name, @last_name, @email, @password, @age, @city, @occupation]
    end

    puts "\n\n---- User Registered Successfully ----"
  end
end