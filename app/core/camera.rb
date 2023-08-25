require 'rmagick'
class Camera
  include Magick
  attr_accessor :x_pixels, :y_pixels, :image

  def initialize(x_pixels, y_pixels)
    self.x_pixels = x_pixels
    self.y_pixels = y_pixels
    self.image = Image.new(self.x_pixels,self.y_pixels) { |options| options.background_color = "red" }
    @fovx_deg = 90
    @distance_film = 0.1
    @look_at = Vec3.new(0, 1, 0)
    @up = Vec3.new(0, 0, 1)
    @position = Point3.new(0, 0, 0)

    film_half_width = Math.tan(Util.deg_to_rad(@fovx_deg / 2)) * @distance_film
    film_half_height = (self.y_pixels * film_half_width) / self.x_pixels
    # p film_half_width
    # p film_half_height
    # TODO: compute x and y step_offset
  end

  def generate_ray(x, y)
    # TODO:
  end

  def set_pixel(x, y, hexcolor)
    self.image.pixel_color x, y, "##{hexcolor}"
  end

  def store_image(path)
    self.image.write path
  end
end
