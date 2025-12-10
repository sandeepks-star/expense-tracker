require 'csv'
require_relative 'User_Schema.rb'

class Registration
  USER_HEADERS = ["Name", "Last_Name", "Email", "Password", "Age", "City", "Occupation"]
  EXPENSE_HEADERS = ["Date", "Category", "Amount", "Notes"]

  def name_input
    puts "\n\nEnter you name::"
    @name = gets.chomp
    loop do
      return if @name.length>=2 && @name.match(/[a-zA-Z]+$/)
      puts "Name must be atleast of 2 characters"
      @name = gets.chomp
    end
  end

  def last_name_input
    puts "\n\nEnter your Last Name::"
    @last_name = gets.chomp
    loop do
      return if @last_name.length>=0 || @last_name.match(/[a-zA-Z]+$/)
      puts "Name must be a characters"
      @last_name = gets.chomp
    end
  end

  def email_input
    puts "\n\nEnter your Email::"
    @email = gets.chomp
    loop do
      return if @email.include?("@" && ".com" || "shriffle" || "gmail" || "yahoo" || "apple" || "microsoft")
      puts "Invalid email"
      @email = gets.chomp
    end
  end

  def password_input
    puts "\n\nCreate Password::"
    @password = gets.chomp
    loop do
      return if @password.length >= 6 && @password.match?(/^(?=.*\d)(?=.*[a-zA-Z])(?=.*[~!@#$%^&*()_+{}\[\]:;<>,.?\/\\-])[a-zA-Z0-9~!@#$%^&*()_+{}\[\]:;<>,.?\/\\-]+$/)

      puts "Password must be atleast of 6 characters including one special character and Alphanumeric Characters"
      @password = gets.chomp
    end
  end

  def age_input
    puts "\n\nEnter your Age::"
    @age = gets.chomp.to_i
    loop do
      return if @age.to_i>5
      puts "Invalid age"
      @age = gets.chomp.to_i
    end
  end

  def city_input
    puts "\n\nEnter your City::"
    @city = gets.chomp
    loop do
      return if @city.length>2 && @city_input.match(/[a-zA-Z]+$/)
      puts "Invalid city name"
      @city = gets.chomp
    end
  end

  def occupation_input
    puts "\n\nEnter your Occupation::"
    @occupation = gets.chomp
    loop do
      return if @occupation.length>2 && @occupation.match(/[a-zA-Z]+$/)
      puts "Invalid Occupation name"
      @occupation = gets.chomp
    end
  end

  def registration_details
    puts "\n\n==>> Enter your details to Register <<=="

    name_input

    last_name_input

    email_input

    password_input

    age_input

    city_input

    occupation_input

    u_details = UserSchema.new(@name, @last_name, @email, @password, @age, @city, @occupation)

    u_details_array = [u_details.name, u_details.last_name, u_details.email, u_details.password, u_details.age, u_details.city, u_details.occupation]

    unless File.exist?("User_details.csv")
      CSV.open("User_details.csv", "w") do |csv|
        csv << USER_HEADERS
      end
    end

    CSV.foreach("User_details.csv", "r", headers:true) do |row|
      return puts "\nEmail already registered, Please Log In\n" if row.fields.include?(@email)
    end


    CSV.open("User_details.csv", "a") do |csv|
      csv << u_details_array
    end

    # unless File.exist?("#{email}.csv")
    #   CSV.open("#{email}.csv", "w") do |csv|
    #     csv << EXPENSE_HEADERS
    #   end
    # end


    puts "\n\n---- User Registered Successfully ----"

  end
end