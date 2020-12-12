class Ship
  attr_reader :name,
              :length,
              :health

  def initialize(name, length)
    @name = name
    @length = @health = length
  end

  def sunk?
    @health.zero?
  end

  def hit
    @health -= 1 unless sunk?
  end
end

#ship is alive with full hp
# ship is shot upon
# health goes down (renders h)
# ship
