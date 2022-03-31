# remove assigments to params

# before

def discount(input_val, quantuty, year_to_date)
  if input_val > 50
    input_val -= 2
  end
end




# after



def discount(input_val, quantuty, year_to_date)
  result = input_val
  if input_val > 50
    result -= 2
  end
end


