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
