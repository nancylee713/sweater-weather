require 'rails_helper'

RSpec.describe TimeMachineService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!

    google_direction_data = {
      :duration=>{:text=>"1 hour 48 mins", :value=>6450},
      :end_address=>"Pueblo, CO, USA",
      :end_location=>{:lat=>38.2542053, :lng=>-104.6087488},
      :start_address=>"Denver, CO, USA",
      :start_location=>{:lat=>39.7411598, :lng=>-104.9879112}
    }

    time = {:text=>"1 hour 48 mins", :value=>6450}

    @time_machine_service = TimeMachineService.new(google_direction_data, time)
  end

  it "exits" do
    expect(@time_machine_service).to be_a(TimeMachineService)
  end

  it "can get direction info" do
    json_data = @time_machine_service.get_data

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:currently)
    expect(json_data[:currently][:time].class).to eq(Integer)
    expect(json_data[:hourly]).to have_key(:summary)
    expect(json_data[:hourly][:data].first).to have_key(:time)
    expect(json_data[:hourly][:data].first).to have_key(:temperature)
  end
end
