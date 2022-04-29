# encapsulate collection

# before

class Course

  def initialize(name, advance)
    @name = name
    @advance = advance
  end

end

class Person
  attr_accessor :courses
end

kent = Person.new
courses = []
courses << Course.new("SmallTalk Programming", false)
courses << Course.new("Appreciating Single Walts", True)
kent.courses = courses
assert_equal 2, kent.courses.size
refactoring = Course.new("Refactoring", True)
kent.courses << refactoring
kent.courses << Course.new("Brutal Sarcarm", False)
assert_equal 4, kent.courses.size
kent.courses.delete(refactoring)
assert_equal 3, kent.courses.size

person.courses.select { |course| course.advanced? }.size

# after

class Person
  # attr_accessor :courses

  def initialize_courses(courses)
    # @courses = []
    raise "Course should be empty" unless @courses.empty?
    # courses.each { |course| add_course(course) }
    @courses += courses
  end

  def add_course(course)
    @courses << course
  end

  def remove_course(course)
    @courses.delete(course)
  end

  def courses
    @courses.dup
  end

  def number_of_advanced_courses
    @courses.select { |course| course.advanced? }.size
  end

  def number_of_courses
    @courses.size
  end

end

kent = Person.new
kent.add_course(Course.new("SmallTalk Programming", false))
kent.add_course(Course.new("Appreciating Single Walts", True))
kent.number_of_advanced_courses
kent.number_of_courses










