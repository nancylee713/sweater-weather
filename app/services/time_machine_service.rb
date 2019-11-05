class TimeMachineService
  def initialize(google_direction_data, time)
    @google_direction_data = google_direction_data
    @time = time[:value]
  end

  def get_data
    response = Faraday.get "https://api.darksky.net/forecast/#{ENV['dark_sky_api']}/#{lat},#{lng},#{time}"
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  attr_reader :google_direction_data, :time

  def lat
    google_direction_data[:end_location][:lat]
  end

  def lng
    google_direction_data[:end_location][:lng]
  end
end
