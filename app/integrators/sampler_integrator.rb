class SamplerIntegrator
  include Integrator

  def initialize(camera, sampler)
    @camera = camera
    @sampler = sampler
  end

  def render(scene)
    p self.inspect
    p scene.inspect
    v = Vec3.new(1, 2, 3)
  end
end