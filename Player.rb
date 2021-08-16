class Player
  attr_accessor :lives
  attr_reader :name

  def initialize(name)
    self.lives = 3
    @name = name
  end

  def prompt
    puts "#{name}: " + yield
  end
end
