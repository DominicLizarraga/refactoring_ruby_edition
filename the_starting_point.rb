# this is the first glance the book gives you of what refactoring really means

# first example


# **** before without refactoring ****


class Movie

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDREN = 2

  attr_reader :title
  attr_accessor :price_code

  def initialize(title, price_code)
    @title, @price_code = title, price_code
  end

end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end
end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end



  def statement
    total_amount, frequent_renter_points = 0, 0
    result = "Rental Record for #{@name}\n"
    @rentals.each do |element|
      this_amount = 0

      # determine amount for each line
      case element.movie.price_code
      when Movie::REGULAR
        this_amount += 2
        this_amount += (element.days_rented - 2) * 1.5 if element.days_rented > 2
      when Movie::NEW_RELEASE
        this_amount += element.days_rented * 3
      when Movie::CHILDREN
        this_amount += 1.5
        this_amount += (element.days_rented - 3) * 1.5 if element.days_rented > 2
      end

      # add frequent renter points
      frequent_renter_points += 1
      # add bonus for a two day new release rental
      if element.movie.price_code == Movie::NEW_RELEASE && element.days_rented > 1
        frequent_renter_points += 1
      end
      # show figures for this rental

      result += "\t" + element.movie.title + "\t" + this_amount.to_s + "\n"
      total_amount += this_amount
    end
    # add footer line
    result += "Amount owed is #{total_amount}\n"
    result += "You earned #{frequent_renter_points} frequent renter points"
    result

  end
end

# **** when refactoring starts ****


class Movie

  REGULAR = 0
  NEW_RELEASE = 1
  CHILDREN = 2

  attr_reader :title
  attr_writer :price_code


  def initialize(title, the_price_code)
    @title, self.price_code = the_title, price_code
  end

  def frequent_renter_points(days_rented)
    @price,frequent_renter_points(days_rented)
  end

  def charge(days_rented)
    @price.charge(days_rented)

  end

  # def price_code=(value)
  #   @price_code= value
  #   @price = case price_code
  #   when REGULAR: RegularPrice.new
  #   when NewReleasePrice: NewReleasePrice.new
  #   when ChildrenPrice: ChildrenPrice.new
  #   end
  # end
end

module DefaultPrice
  def frequent_renter_points(days_rented)
    1
  end
end

class RegularPrice
  include Price
  def charge(days_rented)
    result += 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end


end

class NewReleasePrice
  include Price
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points
    days_rented > 1 ? 2 : 1
  end
end

class ChildrenPrice
  include Price
  def charge
    result += 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 2
    result
  end

end

class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end



  # determine amount for each line

  def charge
    movie.charge(days_rented)
  end

  # add bonus for a two day new release rental
  def frequent_renter_points
    movie.frequent_renter_points(days_rented)
  end


end

class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    frequent_renter_points = 0
    result = "<h1>Rentals for <em> #{@name}</em></h1>\n"
    @rentals.each do |element|
      # show figures for this rental

      result += "\t" + element.movie.title + ": " + element.charge.to_s + "<br>\n"
      total_amount += element.charge

    # add footer line

      result += "<p>You owe <em> #{total_charge}</em></p>\n"
      result += "On ths rental you earned " +
                "<em> #{total_frequent_renter_points} </em> " +
                "frequent renter points</p>"
      result
    end

    def amount_for(rental)
      rental.charge
    end

  end

  private

  def total_charge
    @rentals.inject(0) { |sum, rental| sum += rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0) { |sum, rental| sum += rental.frequent_renter_points }
  end
end

# before callling

movie = Movie.new("The Watchmen", Movie::NEW_RELEASE)
movie.price_code = Movie::NEW_RELEASE

# After calling

movie = Movie.new("The Watchmen", NewReleasePrice.new)
movie.price_code = RegularPrice.new

