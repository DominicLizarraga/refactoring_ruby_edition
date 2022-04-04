# refactoring on coditionals

# before

if date < SUMMER_START || date > SUMMER_END
  charge = quantity * @winter_rate + @winter_service_charge
else
  charge = quantity * @summer_rate
end


# after

if not_summer?
  charge = winter_charge quantity
else
  charge = summer_charge quantity
end

def not_summer?
  date < SUMMER_START || date > SUMMER_END
end

def winter_charge quantity
  quantity * @winter_rate + @winter_service_charge
end

def summer_charge quantity
  quantity * @summer_rate
end


# recompose ternary

# before

parameters = params ? params : []

# after

parameters = params || []



# replace conditional with explicit return


# before

def reward_points
  if days_rented > 2
    2
  else
    1
  end
end



# after

def reward_points
  return 2 if days_rented > 2
    1
end


