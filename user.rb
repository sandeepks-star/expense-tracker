class User
  attr_reader :name, :last_name, :email, :password, :age, :occupation, :city
  def initialize(name, last_name, email, password, age, occupation, city)
    @name = name
    @last_name = last_name
    @email = email
    @password = password
    @age = age
    @occupation = occupation
    @city = city
  end

  def user_array
    u_array = [name, last_name, email, password, age, occupation, city]
  end

end