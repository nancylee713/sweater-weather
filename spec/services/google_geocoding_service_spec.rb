require 'rails_helper'

RSpec.describe GoogleGeocodingService do
  it "can get latitude and longitude of a given city" do
    json_data = GoogleGeocodingService.get_location(
      city: "Denver",
      state: "CO"
    )
    expect(json_data).to be_a(Hash)
    expect(json_data).to have_key(:results)
    latitude = json_data[:results].first[:geometry][:location][:lat]
    expect(latitude).to have_key(:location)
    expect(latitude).to have_key(:lat)
    longitude = json_data[:results].first[:geometry][:location][:lng]
    expect(longitude).to have_key(:location)
    expect(longitude).to have_key(:lng)
  end
end
