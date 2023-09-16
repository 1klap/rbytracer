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

  def scale(scalar)
    Vec3.new self.x * scalar, self.y * scalar, self.z * scalar
  end

  def normalize
    length = self.length
    Vec3.new self.x / length, self.y / length, self.z / length
  end

  def length
    Math.sqrt((x*x) + (y*y) + (z*z))
  end
end