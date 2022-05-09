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

  extend Forwardable
  def_delegator :@bike_type, :@off_road_ability

  # attr_reader :type_code, :front_fork_travel, :front_suspension_price, :base_price, :comission

  def initialize(bike_type)
    # set_state_from_hash(params)
    @bike_type = bike_type
  end

  def type_code=(value)
    @type_code = value
    @bike_type = case type_code
      when :rigid: RigidMountainBike.new(
        :tire_width => @tire_width,
        :base_price => @base_price,
        :comission => @comission
        )
      when :front_suspension: FrontSuspensionMountainBike.new(
        :tire_width => @tire_width,
        :front_fork_travel => @front_fork_travel,
        :base_price => @base_price,
        :comission => @comission
        )
      when :full_suspension: FullSuspensionMountainBike.new(
        :tire_width => @tire_width,
        :front_fork_travel => @front_fork_travel,
        :rear_fork_travel => @rear_fork_travel,
        :base_price => @base_price,
        :comission => @comission
        )
    end
  end

  def upgradable_parameters
    {
      :tire_width => @tire_width,
      :base_price => @base_price,
      :comission => @comission
    }
  end

  def add_front_suspension(params)
    # self.type_code = :front_suspension
    @bike_type = FrontSuspensionMountainBike.new(
      @bike_type.upgradable_parameters.merge(params)
      )
    # set_state_from_hash(params)
  end

  def add_rear_suspension(params)
    unless type_code == :front_suspension
      raise "You can't add rear suspension unless you have front suspension"
    end
    # self.type_code = :full_suspension
    @bike_type = FullSuspensionMountainBike.new(
      @bike_type.upgradable_parameters.merge(params))
    # set_state_from_hash(params)
  end

  def off_road_ability
    return @bike_type.off_road_ability if type_code == :rigid
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

  end

  private

  # def set_state_from_hash(hash)
  #   @base_price = hash[:base_price] if hash.has_key? (:base_price)
  #   if hash.has_key?(:front_suspension_price)
  #     @front_suspension_price = hash[:front_suspension_price]
  #   end
  #   if hash.has_key?(:rear_suspension_price)
  #     @rear_suspension_price = hash[:rear_suspension_price]
  #   end
  #   if hash.has_key?(:comission)
  #     @comission = hash[:comission]
  #   end
  #   if hash.has_key?(:tire_width)
  #     @tire_width = hash[:tire_width]
  #   end
  #   if hash.has_key?(:front_fork_travel)
  #     @front_fork_travel = hash[:front_fork_travel]
  #   end
  #   if hash.has_key?(:rear_fork_travel)
  #     @rear_fork_travel = hash[:rear_fork_travel]
  #   end
  #   self.type_code = hash[:type_code] if hash.has_key?(:type_code)
  # end

end

class RigidMountainBike

  def initialize(params)
    @tire_width = params[:tire_width]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR
  end

  def price
    (1 + comission) + @base_price
  end

end


class FronSuspensionMountainBike

  # attr_reader :tire_width, :front_suspension, :front_suspension_price, :base_price, :comission

  def initialize(params)
    @tire_width = params[:tire_width]
    @front_fork_travel = params[:front_fork_travel]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR + @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR
  end

  def price
    (1 + comission) + @base_price + @front_suspension_price
  end

  def upgradable_parameters
    {
      :tire_width => @tire_width,
      :front_fork_travel => @front_fork_travel,
      :front_suspension_price => @front_suspension_price,
      :base_price => @base_price,
      :comission => @comission
    }
  end


end

class FullSuspensionMountainBike
  def initialize(params)
    @tire_width = params[:tire_width]
    @front_fork_travel = params[:front_fork_travel]
    @rear_fork_travel = params[:rear_fork_travel]
  end

  def off_road_ability
    @tire_width * MountainBike::TIRE_WIDTH_FACTOR + @front_fork_travel * MountainBike::FRONT_SUSPENSION_FACTOR + @rear_fork_travel * MountainBike::REAR_SUSPENSION_FACTOR
  end

  def price
    (1 + comission) + @base_price + @front_suspension_price + @rear_suspension_price
  end
end




bike = MountainBike.new(FronSuspensionMountainBike.new(
    :tire_width => @tire_width,
    :front_fork_travel => @front_fork_travel,
    :base_price => @base_price,
    :comission => @comission
  ))



