require 'csv'
require_relative 'user.rb'
require_relative 'validator_module.rb'

class Registration
  include Validators
  USER_HEADERS = ["name", "last_name", "email", "password", "age", "city", "occupation"]
  EXPENSE_HEADERS = ["date", "category", "amount", "notes"]

  private def call_validators
    name_validator
    lastname_validator
    email_validator
    password_validator
    age_validator
    city_validator
    occupation_validator
  end

  def registration_details
    puts "\n\n==>> Enter your details to Register <<=="
    call_validators

    u_details = User.new(@name, @last_name, @email, @password, @age, @city, @occupation)

    register_array = u_details.user_array

    unless File.exist?("user_details.csv")
      CSV.open("user_details.csv", "w") do |csv|
        csv << USER_HEADERS
      end
    end

    CSV.foreach("user_details.csv", "r", headers:true) do |row|
      user_id = row.to_h
      return puts "\nEmail already registered, Please use different E-mail Id\n\n" if @email == user_id['email']
    end

    unless File.exist?("#{@email}.csv")
      CSV.open("#{@email}.csv", "w") do |csv|
        csv << EXPENSE_HEADERS
      end
    end

    CSV.open("user_details.csv", "a") do |csv|
      csv << register_array
    end

    puts "\n\n---- User Registered Successfully ----"
  end
end