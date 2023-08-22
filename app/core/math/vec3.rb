class Vec3
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
  end

  def add!(another_vec)
    self.x += another_vec.x
    self.y += another_vec.y
    self.z += another_vec.z
    self
  end

  def add(another_vec)
    Vec3.new self.x + another_vec.x, self.y + another_vec.y, self.z + another_vec.z
  end
end