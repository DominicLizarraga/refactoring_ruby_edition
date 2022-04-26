# change unidirectional association to bidirectional

# on to many



class Order

  attr_reader :customer

  def initialize
    @orders = Set.new
  end

  def customer=(value)
    customer.friend_orders.substract(self) unless customer.nil?
    @customer = value
    customer.friend_orders.add(self) unless customer nil?
  end

end


class Customer


  def add_order(order)
    order.customer = self
  end

  def friend_orders
    # should only be used by Order when modifiying the association
    @orders
  end

end


# many to many



class Order
  #controlling methods

  def add_customer(customer)
    customer.friend_orders.add(self)
    @customer.add(customer)
  end

  def remove_customer(customer)
    customer.friend_orders.substract(self)
    @customer.substract(customer)
  end

end

class Customer

  def add_order(order)
    order.add_customer(self)
  end

  def remove_order(order)
    order.remove_customer(self)
  end



end












