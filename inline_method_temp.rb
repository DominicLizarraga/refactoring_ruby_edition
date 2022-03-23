# Extract method

# before


base_price = an_order.base_price
return (base_price > 1000)

# after

return (an_order.base_price > 1000)



# before

base_price = @quantity * @item_price

if (base_price > 1000)
  base_price * 0.95
else
  base_price * 0.98
end


# after



def base_price
  @quantity * @item_price
end

def discuount_factor
  base_price > 1000 ? 0.95 : 0.98
end


def price
  base_price * discuount_factor
end



