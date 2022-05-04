# replace type code with Polymorphism

# this is one of the most complicated examples I had to wrap my mind around, reade it till the end, it's worth it.

# before
class MountainBike

  def initialize(params)
    params.each { |key, value| instance_variable_set "@#{key}", value}
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_FACTOR
    if @type_code == :front_suspension || @type_code == :full_suspension
      result += @front_fork_travel * FRONT_SUSPENSION_FACTOR
    end
    if @type_code == :full_suspension
      result += @rear_fork_travel * REAR_SUSPENSION_FACTOR
    end
    result
  end


  def price
    case @type_code
      when :rigid
        (1 + @commision) * @base_price
      when :front_suspension
        (1 + @commision) * @base_price + @front_suspension_price
      when :full_suspension
        (1 + @commision) * @base_price + @front_suspension_price + @rear_suspension_price
    end
  end
end


# it can be used like this:


bike = MountainBike.new(:type_code => :rigid, :tire_width => 2.5)
bike2 = MountainBike.new(:type_code => :front_suspension, :tire_width => 2, :front_fork_travel => 3)


# this is where Polymorphism starts

module MountainBike
  def wheel_circumference
    Math::PI * (@wheel_diameter + @tire_diameter)
  end

  #no conditional nor type code needed

end

class RigidMountainBike
  include MountainBike

  def price
    (1 + @commision) * @base_price
  end

  def off_raod_ability
    @tire_width * TIRE_WIDTH_FACTOR
  end
end


class FrontSuspensionMountainBike
  include MountainBike

  def price
    (1 + @commision) * @base_price + @front_suspension_price
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENSION_FACTOR
  end
end


class FullSuspensionMountainBike
  include MountainBike

  def price
    (1 + @commision) * @base_price + @front_suspension_price + @rear_suspension_price
  end

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR + @front_fork_travel * FRONT_SUSPENSION_FACTOR + @rear_suspension_price * REAR_SUSPENSION_FACTOR
  end
end


bike = FrontSuspensionMountainBike.new(:tire_width => 2, :front_fork_travel => 3)


