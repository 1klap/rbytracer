require 'benchmark'
# require 'async'
require 'digest'
require 'securerandom'
require "rmagick"
include Magick

def fact(n)
  n == 1 ? 1 : n * fact(n-1)
end

Benchmark.bm do |r|
  r.report('seq:') do
    res = []
    50.times do |x|
      100.times do |y|
        # res << [x, y, SecureRandom.hex(3)]
        res << [x, y, 1.times { fact(1000) }]
      end
    end
    f = Image.new(50,100) { |options| options.background_color = "red" }
    res.each do |r|
      # f.pixel_color r[0], r[1], "##{r[2]}"
    end
    f.write 'parallel.png'
  end

  r.report('ractors:') do
    ractors = []
    50.times do |x|
      100.times do |y|
        pixels = [x, y]
        ractor = Ractor.new do
          arr = Ractor.receive
          # [arr[0],arr[1],SecureRandom.hex(3)]
          [arr[0],arr[1], 1.times { fact(1000) }]
        end
        ractor.send [x, y] 
        ractors << ractor
      end
    end
    # take response from ractor, so it will actually execute
    res = ractors.map(&:take)
    #p res
    f = Image.new(50,100) { |options| options.background_color = "red" }
    res.each do |r|
      # f.pixel_color r[0], r[1], "##{r[2]}"
    end
    f.write 'parallel.png'
  end
end

