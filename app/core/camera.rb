require 'rmagick'
class Camera
  include Magick
  attr_accessor :x_pixels, :y_pixels, :image

  def initialize(x_pixels, y_pixels)
    self.x_pixels = x_pixels
    self.y_pixels = y_pixels
    self.image = Image.new(self.x_pixels,self.y_pixels) { |options| options.background_color = "red" }
  end

  def set_pixel(x, y, hexcolor)
    self.image.pixel_color x, y, "##{hexcolor}"
  end

  def store_image(path)
    self.image.write path
  end
end
