require 'rmagick'
class Camera
  include Magick
  attr_accessor :x_pixels, :y_pixels, :image

  def initialize(x_pixels, y_pixels)
    self.x_pixels = x_pixels
    self.y_pixels = y_pixels
    self.image = Image.new(self.x_pixels,self.y_pixels) { |options| options.background_color = "red" }
    @fovx_deg = 90
    @distance_film = 1
    @look_at = Vec3.new(0, 0, -1)
    @up = Vec3.new(0, 1, 0)
    @position = Point3.new(0, 0, 0)
    @aspect_ratio = self.x_pixels / self.y_pixels
    # @scale = Math.tan(Util.deg_to_rad(@fovx_deg * 0.5))

    # film_half_width = Math.tan(Util.deg_to_rad(@fovx_deg / 2)) * @distance_film
    # film_half_height = (self.y_pixels * film_half_width) / self.x_pixels
    # p film_half_width
    # p film_half_height
    # TODO: compute x and y step_offset

    @viewport_height = 2.0
    @viewport_with = @viewport_height * @aspect_ratio
    @viewport_u = Vec3.new(@viewport_with, 0, 0)
    @viewport_v = Vec3.new(0, -@viewport_height, 0)
    @pixel_delta_u = @viewport_u.scale( 1.0 / self.x_pixels )
    @pixel_delta_v = @viewport_v.scale( 1.0 / self.y_pixels )
    @viewport_upper_left = @position.sub_vec(Vec3.new(0, 0, @distance_film))
                                    .sub_vec(@viewport_u.scale(0.5))
                                    .sub_vec(@viewport_v.scale(0.5))
    @pixel00_loc = @viewport_upper_left.add_vec(@pixel_delta_u.add(@pixel_delta_v).scale(0.5))

    p "@pixel00_loc = #{@pixel00_loc.inspect}"
    # TODO: compute camera_to_world

  end

  def generate_ray(x, y)
    # p_raster_space = [x + 0.5, y + 0.5]
    pixel_center = @pixel00_loc.add_vec(@pixel_delta_u.scale(x)).add_vec(@pixel_delta_v.scale(y))
    ray_direction = pixel_center.sub_point(@position)
    Ray.new @position, ray_direction
  end

  def set_pixel(x, y, hexcolor)
    self.image.pixel_color x, y, "##{hexcolor}"
  end

  def store_image(path)
    self.image.write path
  end
end
