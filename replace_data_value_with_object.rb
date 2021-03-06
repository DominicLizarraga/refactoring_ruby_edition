# replace deata value with object

# before


class Order

  attr_accessor :customer

  def initialize(customer)
    @customer = customer
  end

  def self.number_of_orders_for(orders, customer)
    orders.select { |order| order.customer == customer }.size
  end

end

# after


class Customer
  attr_reader :name

  def initialize(name)
    @name = name
  end

end

class Order

  def initialize(customer_name)
    @customer = Customer.new(customer_name)
  end

  def customer=(customer_name)
    @customer = Customer.new(customer_name)
  end

  def customer_name
    @customer.name
  end

end
