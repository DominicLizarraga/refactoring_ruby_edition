# change value to reference

# before

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

  private

  def self.number_of_orders_for(orders, customer)
    orders.select { |order| order.name == customer }.size
  end

end

# after

class Customer
  attr_reader :name

  Instances = {}

  def self.with_name(name)
    Instances[name]
  end

  def self.load_customer
    new('Lemon Car Drive').store
    new('Associated Coffee Machine').store
    new('Bilston Gasworks').store
  end

  def store
    Instances[name] = self
  end

end

class Order

  def initialize(customer_name)
    @customer = Customer.create(customer_name)
  end

  def customer=(customer_name)
    @customer = Customer.new(customer_name)
  end

  def customer_name
    @customer.name
  end

  private

  def self.number_of_orders_for(orders, customer)
    orders.select { |order| order.name == customer }.size
  end

end


Customer.with_name("Mc Donalds")


