# replace type code with Strategy/State

# this is one of the most complicated examples I had to wrap my mind around, read it till the end, it's worth it.

# before
class MountainBike

  def initialize(params)
    set_state_from_hash(params)
  end

  def add_front_suspension(params)
    @type_code = :add_front_suspension
    set_state_from_hash(params)
  end

  def add_rear_suspension(params)
    unless @type_code == :front_suspension
      raise "You can't add rear suspension unless you have front suspension"
    end
    @type_code = :full_suspension
    set_state_from_hash(params)
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_SUSPENSION
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
        (1 + comission) + @base_price
      when :front_suspension
        (1 + comission) + @base_price + @front_suspension_price
      when :full_suspension
        (1 + comission) + @base_price + @front_suspension_price + @rear_suspension_price
    end
  end


  private

  def set_state_from_hash(hash)
    @base_price = hash[:base_price] if hash.has_key? (:base_price)
    if hash.has_key?(:front_suspension_price)
      @front_suspension_price = hash[:front_suspension_price]
    end
    if hash.has_key?(:rear_suspension_price)
      @rear_suspension_price = hash[:rear_suspension_price]
    end
    if hash.has_key?(:comission)
      @comission = hash[:comission]
    end
    if hash.has_key?(:tire_width)
      @tire_width = hash[:tire_width]
    end
    if hash.has_key?(:front_fork_travel)
      @front_fork_travel = hash[:front_fork_travel]
    end
    if hash.has_key?(:rear_fork_travel)
      @rear_fork_travel = hash[:rear_fork_travel]
    end
    @type_code = hash[:type_code] if hash.has_key?(:type_code)
  end

end

# this is where the refactoring begins


# first self-encapsulate the field on the type code

class MountainBike

  attr_reader :type_code

  def initialize(params)
    set_state_from_hash(params)
  end

  def type_code=(value)
    @type_code = value
  end

  def add_front_suspension(params)
    self.type_code = :front_suspension
    set_state_from_hash(params)
  end

  def add_rear_suspension(params)
    unless type_code == :front_suspension
      raise "You can't add rear suspension unless you have front suspension"
    end
    self.type_code = :full_suspension
    set_state_from_hash(params)
  end

  def off_road_ability
    result = @tire_width * TIRE_WIDTH_SUSPENSION
    if type_code == :front_suspension || type_code == :full_suspension
      result += @front_fork_travel * FRONT_SUSPENSION_FACTOR
    end
    if type_code == :full_suspension
      result += @rear_fork_travel * REAR_SUSPENSION_FACTOR
    end
    result
  end

  def price
    case type_code
      when :rigid
        (1 + comission) + @base_price
      when :front_suspension
        (1 + comission) + @base_price + @front_suspension_price
      when :full_suspension
        (1 + comission) + @base_price + @front_suspension_price + @rear_suspension_price
    end
  end

  private

  def set_state_from_hash(hash)
    @base_price = hash[:base_price] if hash.has_key? (:base_price)
    if hash.has_key?(:front_suspension_price)
      @front_suspension_price = hash[:front_suspension_price]
    end
    if hash.has_key?(:rear_suspension_price)
      @rear_suspension_price = hash[:rear_suspension_price]
    end
    if hash.has_key?(:comission)
      @comission = hash[:comission]
    end
    if hash.has_key?(:tire_width)
      @tire_width = hash[:tire_width]
    end
    if hash.has_key?(:front_fork_travel)
      @front_fork_travel = hash[:front_fork_travel]
    end
    if hash.has_key?(:rear_fork_travel)
      @rear_fork_travel = hash[:rear_fork_travel]
    end
    self.type_code = hash[:type_code] if hash.has_key?(:type_code)
  end

end

class RigidMountainBike

end


class FronSuspensionMountainBike

end

class FullSuspensionMountainBike

end





