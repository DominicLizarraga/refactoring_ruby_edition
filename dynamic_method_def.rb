# dinamyc method definition

# before

def failure
  self.state = :failure
end


def error
  self.state = :error
end


# after


def_each :failure, :error do |method_name|
  self.state = method_name
end
