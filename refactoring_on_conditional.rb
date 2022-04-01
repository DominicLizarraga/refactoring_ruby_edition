# refactoring on coditionals

# before

if date < SUMMER_START || date > SUMMER_END
  charge = quantity * @winter_rate + @winter_service_charge
else
  charge = quantity * @summer_rate
end


# after

if not_summer?
  charge = winter_rate quantity
else
  charge = summer_rate quantity
end

def not_summer?
  date < SUMMER_START || date > SUMMER_END
end

def winter_rate quantity
  quantity * @winter_rate + @winter_service_charge
end

def summer_rate quantity
  quantity * @summer_rate
end
