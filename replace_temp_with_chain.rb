# temp with chains

# before

mock = Mock.new
expectation = mock.expects(:a_method)
expectation.with("arguments")
expectation.returns([1, :array])


# after

mock = Mock.new
mock.expects(:a_method).with("arguments").returns([1, :array])


# before

class Select
  def options
    @options ||= []
  end

  def add_option(arg)
    options << arg
  end

end

select = Select.new
select.add_option(1999)
select.add_option(2000)
select.add_option(2001)
select.add_option(2002)


# after

class Select

  def self.with_option(option)
    select = self.new
    select.options << option
    select
  end

  def options
    @options ||= []
  end

  def and(arg)
    options << arg
    self
  end

end

select = Select.with_option(1999).and(2000).and(2001).and(2002)















