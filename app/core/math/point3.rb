class Point3
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    self.x = x
    self.y = y
    self.z = z
  end

  def sub_point(point)
    Vec3.new x - point.x, y - point.y, z - point.z
  end

  def sub_vec(vector)
    Point3.new x - vector.x, y - vector.y, z - vector.z
  end

  def add_vec(vector)
    Point3.new x + vector.x, y + vector.y, z + vector.z
  end
end