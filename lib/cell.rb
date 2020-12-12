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
    if !fired_upon?
      @fired_upon = true
      @ship.hit unless empty?
    end
  end

  def render(override=false)
    # if override && !empty? && !fired_upon?
    #   'S'
    # if ship_present?
    #   override ? 'S' : '.'
    if hidden_ship_present? && override
      'S'
    elsif hidden_ship_present? && !override
      '.'
    elsif render_empty?
      '.'
    elsif render_miss?
      'M'
    elsif render_sunk?
      'X'
    elsif render_hit?
      'H'
    else
      require "pry"; binding.pry
      "Something went wrong!"
    end
  end

  private

  def hidden_ship_present?
    !empty? && !fired_upon?
  end

  def render_sunk?
    !empty? && @ship.sunk?
  end

  def render_hit?
    !empty? && fired_upon?
  end

  def render_empty?
    empty? && !fired_upon?
  end

  def render_miss?
    empty? && fired_upon?
  end
end
