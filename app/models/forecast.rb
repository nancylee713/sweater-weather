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
              :summaries

  def initialize(location, weather_data)
    @id = 0
    @location = location.formatted_address
    @current_time = format_time(weather_data)
    @current_sum = weather_data[:currently][:summary]
    @icon = weather_data[:currently][:icon]
    @current_temp = weather_data[:currently][:temperature]
    @temp_high = weather_data[:daily][:data][0][:temperatureHigh]
    @temp_low = weather_data[:daily][:data][0][:temperatureLow]
    @feels_like = weather_data[:hourly][:data][0][:apparentTemperature]
    @humidity = weather_data[:hourly][:data][0][:humidity]
    @visibility = weather_data[:hourly][:data][0][:visibility]
    @uvIndex = weather_data[:hourly][:data][0][:uvIndex]
    @summaries = format_summary(weather_data)
  end

  def format_time(weather_data)
    time = Time.at(weather_data[:currently][:time])
    time.strftime("%I:%M %p, %m/%d")
  end

  def format_summary(weather_data)
    today_timestamp = weather_data[:hourly][:data][0][:time]
    tonight_timestamp = today_timestamp + 21600  # 6 hours later

    { today_sum: weather_data[:hourly][:data][0][:summary],
      tonight_sum: weather_data[:hourly][:data].select {|x| x[:time] == tonight_timestamp}[0][:summary]
    }
  end

  def today_sum
    summaries[:today_sum]
  end

  def tonight_sum
    summaries[:tonight_sum]
  end
end
