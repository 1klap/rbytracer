class Ray
  attr_accessor :o, :d

  def initialize(origin, direction)
    self.o = origin
    self.d = direction
  end
end