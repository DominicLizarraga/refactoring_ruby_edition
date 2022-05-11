# replace subclass

# before

def Female < Person

  def female?
    true
  end

  def code
    'F'
  end

end

class Male < Person

  def female?
    false
  end

  def code
    'M'
  end

end

# after

class Person

  def initialize(female, code)
    @female = female
    @code = code
  end

  def self.create_female
    Person.new(true, 'F')
  end

  def self.create_male
    Person.new(false, 'M')
  end

  def female?
    @female
  end

# the classes male and female are not needed

end


bree = Person.create_female(true, 'F')



