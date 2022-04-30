# lazily initialized attribute

# before

class Employee
  def initialize
    @emails = []
  end

end
# after

class Employee
  def emails
    @emails ||= []
  end
end
