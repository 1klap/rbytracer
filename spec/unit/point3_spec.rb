require 'spec_helper'

RSpec.describe Vec3 do
  it "subtracts another point from itself" do
    p = Point3.new(3, 1, -10)
    another_p = Point3.new(-1, -1, 11)
    v = p.sub_point another_p

    expect(v).to have_attributes(x: 4, y: 2, z: -21)
  end


end
