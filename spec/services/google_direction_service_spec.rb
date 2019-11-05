require 'rails_helper'

RSpec.describe GoogleDirectionService do
  before(:each) do
    VCR.turn_off!
    WebMock.allow_net_connect!

    @direction_service = GoogleDirectionService.new("Denver,CO", "Pueblo,CO")
  end

  it "exits" do
    expect(@direction_service).to be_a(GoogleDirectionService)
  end

  it "can get direction info" do
    json_data = @direction_service.get_direction

    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:distance)
    expect(json_data).to have_key(:duration)
  end
end
