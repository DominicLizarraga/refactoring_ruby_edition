# substitute loop

# before
managers = []

employees.each do |e|
  managers << e if e.manager?
end

# after

managers = employees.select { |e| if e.manager? }

# before

managersOffices = []

employees.each do |e|
  managersOffices << e.office if e.manager?
end

# after

managersOffices = employees.select { |e| if e.manager? }.collect { |e| e.office }
