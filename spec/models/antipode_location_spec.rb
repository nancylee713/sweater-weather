require 'rails_helper'

RSpec.describe AntipodeLocation do
  before(:each) do
    json_data = {:data=>{:id=>"1", :type=>"antipode", :attributes=>{:lat=>-22.3193039, :long=>180.0}}}
    @ap_location = AntipodeLocation.new(json_data)
  end

  it 'is created with antipode location' do
    expect(@ap_location).to be_a(AntipodeLocation)
  end

  it "can return latitude" do
    expected = -22.3193039
    expect(@ap_location.latitude).to eq(expected)
  end

  it "can return longitude" do
    expected = 180.0
    expect(@ap_location.longitude).to eq(expected)
  end
end
