# extract class method

# before

class Person

  attr_reader :name
  attr_accessor :office_area_code
  attr_accessor :office_number

  def telephone_number
    '(' + @office_area_code + ')' + @office_number
  end

end


# after


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







