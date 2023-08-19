require 'rmagick'

require "rmagick"
include Magick
# Create a 100x100 red image.
f = Image.new(100,100) { |options| options.background_color = "red" }
# f.display
# x=20, y=40, starting from topleft corner
f.pixel_color 20, 40, '#000000'
f.write 'red.png'
exit
