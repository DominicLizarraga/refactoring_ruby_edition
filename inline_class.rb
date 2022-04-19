# inline class method

# before

class TelephoneNumber
  attr_accessor :area_code, :numer

  def telephone_number
    '(' + area_code + ')' + number
  end

end

class Person
  attr_reader :name

  def initialize
    @office_telephone = TelephoneNumber.new
  end

  def telephone_number
    @office_telephone.telephone_number
  end

  def office_telephone
    @office_telephone
  end

end



# after

class Person

  def area_code
    @office_telephone.area_code
  end

  def area_code=(arg)
    @office_telephone.area_code = arg
  end

  def number
    @office_telephone.number
  end

  def number=(arg)
    @office_telephone.number = arg
  end

end


martin = Person.new
martin.area_code = '234'


