class SamplerIntegrator
  include Integrator

  def initialize(camera, sampler)
    @camera = camera
    @sampler = sampler
  end

  def render(scene)
    p self.inspect
    p scene.inspect
  end
end