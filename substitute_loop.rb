# substitute loop

# before
managers = []

employees.each do |e|
  managers << e if e.manager?
end

# after

managers = employees.select { |e| if e.manager? }
