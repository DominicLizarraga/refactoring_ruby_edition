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
