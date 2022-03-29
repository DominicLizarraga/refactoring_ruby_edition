# split temp var

# before

temp = 2 * (@height + @width)
puts temp
temp = @height + @width
puts temp

# after

perimeter = 2 * (@height + @width)
puts perimeter
area = @height + @width
puts area


# another split temp var example

# before

def distance_traveled(time)
  acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * acc * primary_time * primary_time
  secondary_time = time - @delay
  if (secondary_time > 0)
    primary_vel = acc * @delay
    acc = (@primary_force + @secondary_force) / @mass
    result += primary_vel * secondary_time + 5 * acc * secondary_time * secondary_time
  end
  result
end


# after

def distance_traveled(time)
  primary_acc = @primary_force / @mass
  primary_time = [time, @delay].min
  result = 0.5 * acc * primary_time * primary_time
  secondary_time = time - @delay
  if (secondary_time > 0)
    primary_vel = primary_acc * @delay
    secondary_acc = (@primary_force + @secondary_force) / @mass
    result += primary_vel * secondary_time + 5 * secondary_acc * secondary_time * secondary_time
  end
  result
end





