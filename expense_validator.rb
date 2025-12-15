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
        @final_date = Date.strptime(input_date,"%d/%m/%Y")
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

    loop do
      break if CATEGORIES.split(', ').include?("#{@category}")
      puts "Invalid selection choose from category #{CATEGORIES}"
      user_input = gets.chomp
      @category = user_input.capitalize!
    end
  end
end