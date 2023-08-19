class Main

  def initialize
    config_autoload
  end

  def execute
    scene = Scene.new
    scene.primitive = Primitive.new Shape.new, Material.new
    integrator = SamplerIntegrator.new(Camera.new, Sampler.new)

    integrator.render(scene)
  end

  def config_autoload
    require 'zeitwerk'
    loader = Zeitwerk::Loader.new
    loader.push_dir("#{__dir__}/core")
    loader.push_dir("#{__dir__}/geometry")
    loader.push_dir("#{__dir__}/integrators")
    loader.push_dir("#{__dir__}/materials")
    loader.setup
  end
end

Main.new.execute