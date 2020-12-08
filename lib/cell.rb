class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship_obj)
    @ship = ship_obj
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
  end

  def render
    if render_empty?
      '.'
    elsif render_miss?
      'M'
    else
      "Something went wrong!"
    end
  end
  
  private

  def render_empty?
    empty? && !fired_upon?
  end

  def render_miss?
    empty? && fired_upon?
  end



end