require 'spec_helper'

RSpec.describe Vec3 do
  it "adds another Vec3 to itself in place" do
    v = Vec3.new(5, -3, 30)
    another_v = Vec3.new(10, 20, -40)
    v.add! another_v

    expect(v).to have_attributes(x: 15, y: 17, z: -10)
  end

  it "adds another Vec3 to itself as a new Vec3" do
    v = Vec3.new(5, -3, 30)
    another_v = Vec3.new(10, 20, -40)
    result_v = v.add another_v

    expect(v).to have_attributes(x: 5, y: -3, z: 30)
    expect(result_v).to have_attributes(x: 15, y: 17, z: -10)
  end
end
