# replace array with object

# before

row = []

row[0] = "Liverpool"
row[1] = "15"

name = row[0]
wins = row[1].to_i

# after

class Performance
  attr_accessor :wins, :name


  def initialize
    @data = []
  end

  def []=(index, value)
    @data.inset(index, value)
  end


  def (index)
    @data[index]
  end

end



row = Performance.new
row.name = "Liverpool"
row.wins = "15"








