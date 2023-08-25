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
end