require 'csv'
require_relative 'User.rb'

module Validators
  def name_validator
    puts "\n\nEnter you name::"
    @name = gets.chomp
    loop do
      return if @name.length>=2 && @name.match(/[a-zA-Z]+$/)
      puts "Name must be atleast of 2 characters"
      @name = gets.chomp
    end
  end

  def lastname_validator
    puts "\n\nEnter your Last Name::"
    @last_name = gets.chomp
    loop do
      return if @last_name.length>=0 || @last_name.match(/[a-zA-Z]+$/)
      puts "Name must be a characters"
      @last_name = gets.chomp
    end
  end

  def email_validator
    puts "\n\nEnter your Email::"
    @email = gets.chomp
    loop do
      return if @email.include?("@" && ".com" || "shriffle" || "gmail" || "yahoo" || "apple" || "microsoft")
      puts "Invalid email"
      @email = gets.chomp
    end
  end

  def password_validator
    puts "\n\nCreate Password::"
    @password = gets.chomp
    loop do
      return if @password.length >= 6 && @password.match?(/^(?=.*\d)(?=.*[a-zA-Z])(?=.*[~!@#$%^&*()_+{}\[\]:;<>,.?\/\\-])[a-zA-Z0-9~!@#$%^&*()_+{}\[\]:;<>,.?\/\\-]+$/)
      puts "Password must be atleast of 6 characters including one special character and Alphanumeric Characters"
      @password = gets.chomp
    end
  end

  def age_validator
    puts "\n\nEnter your Age::"
    @age = gets.chomp.to_i
    loop do
      return if @age.to_i>5
      puts "Invalid age"
      @age = gets.chomp.to_i
    end
  end

  def city_validator
    puts "\n\nEnter your City::"
    @city = gets.chomp
    loop do
      return if @city.length>2 && @city.match(/[a-zA-Z]+$/)
      puts "Invalid city name"
      @city = gets.chomp
    end
  end

  def occupation_validator
    puts "\n\nEnter your Occupation::"
    @occupation = gets.chomp
    loop do
      return if @occupation.length>2 && @occupation.match(/[a-zA-Z]+$/)
      puts "Invalid Occupation name"
      @occupation = gets.chomp
    end
  end
end


class Registration
  include Validators
  USER_HEADERS = ["name", "last_name", "email", "password", "age", "city", "occupation"]
  EXPENSE_HEADERS = ["date", "category", "amount", "notes"]

  def registration_details
    puts "\n\n==>> Enter your details to Register <<=="
    name_validator
    lastname_validator
    email_validator
    password_validator
    age_validator
    city_validator
    occupation_validator
    u_details = User.new(@name, @last_name, @email, @password, @age, @city, @occupation)
    u_details_array = [u_details.name, u_details.last_name, u_details.email, u_details.password, u_details.age, u_details.city, u_details.occupation]
    unless File.exist?("User_details.csv")
      CSV.open("User_details.csv", "w") do |csv|
        csv << USER_HEADERS
      end
    end

    CSV.foreach("User_details.csv", "r", headers:true) do |row|
      return puts "\nEmail already registered, Please Log In\n" if row.fields.include?(@email)
    end

    unless File.exist?("#{@email}.csv")
      CSV.open("#{@email}.csv", "w") do |csv|
        csv << EXPENSE_HEADERS
      end
    end

    CSV.open("User_details.csv", "a") do |csv|
      csv << u_details_array
    end
    puts "\n\n---- User Registered Successfully ----"
  end
end