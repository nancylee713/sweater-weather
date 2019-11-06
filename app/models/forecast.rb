class Forecast
  attr_reader :id,
              :location,
              :current_time,
              :current_sum,
              :icon,
              :current_temp,
              :temp_high,
              :temp_low,
              :feels_like,
              :humidity,
              :visibility,
              :uvIndex,
              :today_summary,
              :hourly_time,
              :hourly_group,
              :daily_group

  def initialize(location, weather_data)
    @id = 0
    @location = location
    @current_time = weather_data[:currently][:time]
    @current_sum = weather_data[:currently][:summary]
    @icon = weather_data[:currently][:icon]
    @current_temp = weather_data[:currently][:temperature]
    @temp_high = weather_data[:daily][:data][0][:temperatureHigh]
    @temp_low = weather_data[:daily][:data][0][:temperatureLow]
    @feels_like = weather_data[:hourly][:data][0][:apparentTemperature]
    @humidity = weather_data[:hourly][:data][0][:humidity]
    @visibility = weather_data[:hourly][:data][0][:visibility]
    @uvIndex = weather_data[:hourly][:data][0][:uvIndex]
    @today_summary = weather_data[:hourly][:data][0][:summary]
    @hourly_time = weather_data[:hourly][:data][0][:time]
    @hourly_group = weather_data[:hourly][:data].first(8)
    @daily_group = weather_data[:daily][:data].first(5)
  end
end
