class RoadTrip
  attr_reader :id, :estimated_travel_time, :eta, :temperature, :summary

  def initialize(data, duration)
    @id = 0
    @estimated_travel_time = duration[:text]
    @eta = format_adjusted_time(duration)
    @temperature = data[:hourly][:data].first[:temperature]   # not sure which data point to select from the 'hourly' hash, by timestamp?
    @summary = data[:hourly][:summary]
  end

  private

  def format_adjusted_time(duration)
    now = Time.now.to_i
    diff = duration[:value]
    unix_time = now + duration[:value]
    adjusted_time = Time.at(unix_time)
    adjusted_time.strftime("%I:%M %p, %m/%d")
  end
end
