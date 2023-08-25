class Scene
  attr_accessor :primitive

  def intersect(ray)
    primitive.intersect(ray)
  end

  def radiance(ray)
    SecureRandom.hex(3)
  end
end