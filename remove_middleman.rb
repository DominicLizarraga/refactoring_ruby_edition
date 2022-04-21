# remove middleman method

# before

class Person

  def initialize(department)
    @department = department
  end

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


# after


class Person
  attr_reader :department

  def initialize(department)
    @department = department
  end

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

manager = john.department.manager


