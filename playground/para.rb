require 'securerandom'
require 'rmagick'
require 'debug'
include Magick

MAX_WORKERS = 16

class Scene
  def radiance
    SecureRandom.hex(3)
  end
end

scene = Scene.new

workers = MAX_WORKERS.times.map do
  Ractor.new do
    while coords = Ractor.receive
      Ractor.yield [coords[0], coords[1], coords[2].radiance]
    end
  end
end

f = Image.new(500,800) { |options| options.background_color = "red" }

500.times do |x|
  800.times do |y|
    coords = [x, y, scene]
    workers[(x*800 + y) % MAX_WORKERS].send(coords)
  end
end

iter = 0
@result_ractors = (500 * 800).times.map do |i|
  _r, result = Ractor.select(*workers)
  f.pixel_color result[0], result[1], "##{result[2]}"
  if i % 15000 == 0
    p i
    # f.pixel_color result[0], result[1], "##{result[2]}"
    f.write "out/parallel_#{iter}.png"
    # debugger
    iter += 1
  end
  result
end

@result_ractors.each do |r|
  f.pixel_color r[0], r[1], "##{r[2]}"
end
f.write 'out/parallel.png'