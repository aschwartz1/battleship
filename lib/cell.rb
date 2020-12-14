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
    shot_message = ""

    if !fired_upon?
      @fired_upon = true
      @ship.hit unless empty?

      shot_message = get_shot_message
    end

    shot_message
  end

  def render(override=false)
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
      "Something went wrong!"
    end
  end

  private

  def get_shot_message
      if !empty? && !@ship.sunk?
        "shot on #{coordinate} was a hit!"
      elsif !empty? && @ship.sunk?
        "shot on #{coordinate} sunk a #{@ship.name}!"
      else
        "shot on #{coordinate} was a miss."
      end
  end

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
