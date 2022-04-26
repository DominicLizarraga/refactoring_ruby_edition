# change reference to value

# before

class Currency

  attr_reader :code

  def initialize(code)
    @code = code
  end

  def self.get(code)
    ...return currency from registry
  end

  def eql?(other)
    self == other
  end

  def ==(other)
    other.equal?(self) ||
    (other.instance_of?(self.class) &&
      other.code == code)
  end

  def hash
    code.hash
  end

end

Currency.send(:new, "USD") == Currency.new("USD") # returns true
Currency.send(:new, "USD").eql?(Currency.new("USD")) # returns true
