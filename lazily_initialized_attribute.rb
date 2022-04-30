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
