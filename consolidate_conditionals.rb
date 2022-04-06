# consolidate coditionals

# before

def disability_amount
  return 0 if @senority < 2
  return 0 if @months_disabled > 12
  return 0 if @is_part_time

end

# after

def disability_amount
 return 0 if ineligable_for_disability?
end

def ineligable_for_disability?
  @senority < 2 || @months_disabled > 12 || @is_part_time
end


# example with ANDS

# before
if on_vacation?
  if length_of_service > 10
    return 1
  end
end

# after

if on_vacation? && length_of_service > 10
  return 1
end


# consolidate duplicate fragments


# before


if special_deal?
  total = price * 0.95
  send_order
else
  total = price * 0.98
  send_order
end

# after

if special_deal?
  total = price * 0.95
else
  total = price * 0.98
end
send_order

