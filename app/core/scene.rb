class Scene
  attr_accessor :primitive

  def intersect(ray)
    primitive.intersect(ray)
  end

  def radiance(ray)
    return "ff0000" if hit_sphere(Point3.new(0, 0, -1), 0.5, ray)

    # SecureRandom.hex(3)
    unit_direction = ray.d.normalize
    a = 0.5 * unit_direction.y + 1
    color = Vec3.new(1, 1, 1).scale(1-a).add(Vec3.new(0.5, 0.7, 1).scale(a))
    r = (color.x * 255).round
    g = (color.y * 255).round
    b = (color.z * 255).round
    "#{r.to_s(16)}#{g.to_s(16)}#{b.to_s(16)}"
  end

  def hit_sphere(center, radius, ray)
    oc = ray.o.sub_point center
    a = ray.d.dot(ray.d)
    b = 2 * oc.dot(ray.d)
    c = oc.dot(oc) - radius * radius
    discriminant = b * b - 4 * a * c
    discriminant >= 0
  end
end