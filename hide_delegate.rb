# hide delegate method

# before

class Person
  attr_accessor :department

end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end

end

# if client wants to know a person department

manager = john.department.manager


# after


class Person
  attr_accessor :department

  def manager
    @department.manager
  end

end

class Department
  attr_reader :manager

  def initialize(manager)
    @manager = manager
  end
end



# if client wants to know a person department

manager = john.manager


