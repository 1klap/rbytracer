class Scene
  attr_accessor :primitive

  def intersect(ray)
    primitive.intersect(ray)
  end

  def radiance(ray)
    # SecureRandom.hex(3)
    unit_direction = ray.d.normalize
    a = 0.5 * unit_direction.y + 1
    color = Vec3.new(1, 1, 1).scale(1-a).add(Vec3.new(0.5, 0.7, 1).scale(a))
    r = (color.x * 255).round
    g = (color.y * 255).round
    b = (color.z * 255).round
    "#{r.to_s(16)}#{g.to_s(16)}#{b.to_s(16)}"
  end
end