# replace type code with Module

# this is one of the most complicated examples I had to wrap my mind around, reade it till the end, it's worth it.

# before
class MountainBike

  attr_writer :type_code

  def initialize(params)
    @type_code = params[:type_code]
    @comission = params[:comission]
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


bike = MountainBike.new(:type_code => :rigid)
bike.type_code = :rigid


# this is where Module Extension starts

class MountainBike

  attr_reader :type_code

  def off_road_ability
    @tire_width * TIRE_WIDTH_FACTOR
  end

  def price
    (1 + @commision) * @base_price
  end

  def type_code=(mod)
    extend(mod)
  end

  #now we can remove altraces of @type_code

end



module FrontSuspensionMountainBike
  include MountainBike

  def price
    (1 + @commision) * @base_price + @front_suspension_price
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR + @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR
  end
end


module FullSuspensionMountainBike
  include MountainBike

  def price
    (1 + @commision) * @base_price + @front_suspension_price + @rear_suspension_price
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR + @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR + @rear_suspension_price * MountainBike::REAR_SUSPENSION_FACTOR
  end
end


bike = MountainBike.new

bike.type_code = FrontSuspensionMountainBike
