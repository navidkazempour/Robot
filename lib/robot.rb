class Robot

  MAX_WEIGHT = 250
  MAX_HEALTH = 100

  attr_reader :position, :items, :health

  attr_accessor :equipped_weapon

  def initialize
    @position = [0, 0]
    @items = []
    @health = MAX_HEALTH
  end

# Rspec test for #heal! and #attack! is added to the 04_robot_health.rb
  def attack!(another_robot)
    if another_robot.is_a?(Robot)
      attack(another_robot)
    else
      raise StandardError, "Enemy should be a Robot!"
    end
  end

  def heal!(amount)
    if health <= 0
      raise StandardError, "robot is dead!"
    end
    heal(amount)
  end

  def attack(another_robot)
    if equipped_weapon
      equipped_weapon.hit(another_robot)
    else
      another_robot.wound(5)
    end
  end

  def wound(amount)
    @health -= amount
    if health < 0
      @health = 0
    end
  end

  def heal(amount)
    @health += amount
    if health > MAX_HEALTH
      @health = MAX_HEALTH
    end
  end

  def pick_up(item)
    if item.is_a?(Weapon)
      self.equipped_weapon = item
    else
      if items_weight + item.weight <= MAX_WEIGHT
        items << item
      end
    end
  end

  def items_weight
    items.inject(0) { |sum, item| sum + item.weight }
    # sum = 0
    # items.each { |item| sum += item.weight }
    # sum
  end

  def move_left
    position[0] -= 1
  end

  def move_right
    position[0] += 1
  end

  def move_up
    position[1] += 1
  end

  def move_down
    position[1] -= 1
  end

end