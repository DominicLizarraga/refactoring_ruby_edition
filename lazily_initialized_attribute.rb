# lazily initialized attribute

# before

class Employee

  def initialize
    @emails = []
  end

end

# after

class Person
  def emails
    @emails ||= []
  end
end


# example using instance_variable_defined?

# before

class Employee

  def initialize
    @assistant = Employee.find_by_boss(self.id)
  end

end


# after

class Employee
  def assistant
    unless instance_variable_defined? :@assistant
      @assistant = Employee.find_by_boss(self.id)
    end
    @assistant
  end

end




