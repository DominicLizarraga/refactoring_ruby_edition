# move field

# before

class Account

  def interest_for_amount_days(amount, days)
    @interest_rate * amount * days / 365
  end

end

# after


class Account

end


class AccountType
  attr_accessor :interest_rate

  def interest_for_amount_days(amount, days)
    @account_type.interest_rate * amount * days / 365
  end
end



# example using self encapsulation


# before

class Account

  def interest_for_amount_days(amount, days)
    @interest_rate * amount * days / 365
  end

end

# after

class Account

  attr_accessor :interest_rate

  def interest_for_amount_days(amount, days)
    interest_rate * amount * days / 365
  end

  private

  def interest_rate
    @account_type.interest_rate
  end

end








