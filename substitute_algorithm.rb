# substitute algorithm

# before

def found_frineds(people)
  friends = []
  people.each do |person|
    if (person == "Ken")
      friends << "Ken"
    end
    if (person == "Jhon")
      friends << "Jhon"
    end
    if (person == "Dan")
      friends << "Dan"
    end
  end
  return friends
end


# after

def found_friends(people)
  people.select do |person|
    %w(Ken Jhon Dan).include? person
  end

end
