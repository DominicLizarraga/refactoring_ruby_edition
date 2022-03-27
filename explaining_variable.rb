# temp with chains

# before

if (platform.upcase.index("MAC") &&
    browser.upcase.index("IE") &&
    initialized? &&
    resize > 0
    )
  # do something

end


# after

  is_mac_os = platform.upcase.index("MAC")
  is_ie_browser = browser.upcase.index("IE")
  was_resized = resize > 0

  if (is_mac_os && is_ie_browser && was_resized && initialized?)
    # do something
  end


# before

def price
  # price is base price - quantity discount + shipping
  return @quantity * @item_price -
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@quantity * @item_price * 0.1, 100.0].min
end


# after

def price
  # price is base price - quantity discount + shipping
   base_price = @quantity * @item_price
   quantity_discount = [0, @quantity - 500].max * @item_price * 0.05
   shipping = [base_price * 0.1, 100.0].min
  return base_price - quantity_discount + shipping
end

# same example with Extract method


# before

def price
  # price is base price - quantity discount + shipping
  return @quantity * @item_price -
    [0, @quantity - 500].max * @item_price * 0.05 +
    [@quantity * @item_price * 0.1, 100.0].min
end


# after

def price
  base_price - quantity_discount + shipping
end

def base_price
  @quantity * @item_price
end

def quantity_discount
  [0, @quantity - 500].max * @item_price * 0.05
end

def shipping
  [base_price * 0.1, 100.0].min
end








