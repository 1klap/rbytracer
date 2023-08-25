class SamplerIntegrator
  include Integrator

  MAX_WORKERS = 16

  def initialize(camera, sampler)
    @camera = camera
    @sampler = sampler
  end

  def render(scene)
    workers = MAX_WORKERS.times.map do
      Ractor.new do
        while args = Ractor.receive
          # args = x, y, scene, ray
          Ractor.yield [args[0], args[1], args[2].radiance(args[3])]
        end
      end
    end

    @camera.x_pixels.times do |x|
      @camera.y_pixels.times do |y|
        ray = nil
        worker_args = [x, y, scene, ray]
        workers[(x * @camera.y_pixels + y) % MAX_WORKERS].send(worker_args)
      end
    end

    results = (@camera.x_pixels * @camera.y_pixels).times.map do |i|
      _r, result = Ractor.select(*workers)
      result
    end

    results.each do |r|
      @camera.set_pixel r[0], r[1], r[2]
    end
    @camera.store_image '../out/render.png'
  end
end