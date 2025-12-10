require_relative 'Login.rb'
require_relative 'Registration.rb'


class Main
  def run
    login = Login.new
    register = Registration.new
    loop do
      puts "=============================================="
      puts "-----Welcome to Personal Expense Tracker -----"
      puts "=============================================="
      puts "\n-----Choose from below options-----"
      puts "\n 1. Login "
      puts "\n 2. Register"
      puts "\n 3. Exit\n\n"

      choice = gets.chomp.to_i

      case choice
      when 1
        login.user_login
      when 2
        register.registration_details
      when 3
        puts "Thank you, Come again"
        break
      end

    end
  end
end

start = Main.new
start.run