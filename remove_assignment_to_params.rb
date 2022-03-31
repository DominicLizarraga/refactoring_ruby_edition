# remove assigments to params

# before

def discount(input_val, quantity, year_to_date)
  if input_val > 50
    input_val -= 2
  end
end




# after



def discount(input_val, quantity, year_to_date)
  result = input_val
  if input_val > 50
    result -= 2
  end
end

# before

def discount(input_val, quantity, year_to_date)
  input_val -= 2 if input_val > 50
  input_val -= 1 if input_val > 100
  input_val -= 4 if input_val > 1000
  input_val
end


# after

def dicount(input_val, quantity, year_to_date)
  result = input_val
  result -= 2 if input_val > 50
  result -= 1 if input_val > 100
  result -= 4 if input_val > 1000
  result
end


