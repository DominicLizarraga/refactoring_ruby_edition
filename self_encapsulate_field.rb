# self encapsulate field

# before

def total
  @base_price * (1 + @tax_rate)
end


# after

attr_reader :base_price, :tax_rate

def total
  @base_price * (1 + @tax_rate)
end


# another example when having a subclass


class Item

  attr_reader :base_price, :tax_rate


  def initialize(base_price, tax_rate)
    setup(base_price, tax_rate)
  end

  def setup(base_price, tax_rate)
    @base_price = base_price
    @tax_rate = tax_rate
  end

  def raise_base_price(percent)
    @base_price = @base_price * (1 + percent/100)
  end

  def total
    @base_price * (1 + @tax_rate)
  end

end


class ImportedItem < Item

  attr_reader :import_duty

  def initialize(base_price, tax_rate, import_duty)
    super(base_price, tax_rate)
    @import_duty = import_duty
  end

  def tax_rate
    super + import_duty
  end

end
