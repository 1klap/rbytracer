class Scene
  attr_accessor :primitive

  def intersect(ray)
    primitive.intersect(ray)
  end
end