# replace magic number with constant

# before

def potential_energy(mass, height)
  mass * 9.81 * height
end

# after

GRAVITATIONAL_CONSTANT = 9.81

def potential_energy(mass, height)
  mass * GRAVITATIONAL_CONSTANT * height
end
