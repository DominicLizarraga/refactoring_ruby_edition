# introduce named params

# before

SearchCriteria.new(5, 8, '1208123465BNQ')

# after

SearchCriteria.new(:author_id: 5, :publisher_id => 8, :isbn => '1208123465BNQ')

