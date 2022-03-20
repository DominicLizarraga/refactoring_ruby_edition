# Extract method

# before

def print_owing(amount)
  print_banner
  puts "name: #{@name}"
  puts "amount: #{amount}"
end

# after

def print_owing(amount)
  print_banner
  print_details(amount)
end

def print_details(amount)
  puts "name: #{@name}"
  puts "amount: #{amount}"
end


# another extract method example

# before
def print_owing
  outstanding = 0.0
  #  print banner
  puts "*********************"
  puts "****Customer Owes****"
  puts "*********************"

  # calculate outstanding
  @orders.each do |order|
    outstanding += order.amount
  end

  # print details
  puts "name: #{@name}"
  puts "amount: #{amount}"

end

# after

def print_owing(previous_amount)
  print_banner
  outstanding = calculate_outstanding(previous_amount)
  print_details outstanding
end

def print_banner
  puts "*********************"
  puts "****Customer Owes****"
  puts "*********************"
end


def calculate_outstanding(initial_value)
    @orders.inject(initial_value) { |result, order| result + order.amount }
  end
end

def print_details outstanding
  puts "name: #{@name}"
  puts "amount: #{outstanding}"
end







