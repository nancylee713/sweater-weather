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
              :summaries,
              :time,
              :hourly_forecast,
              :daily_forecast

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
    @time = weather_data[:currently][:time]
    @hourly_forecast = hourly_group(weather_data)
    @daily_forecast = daily_group(weather_data)
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

  private

  def hourly_group(weather_data)
    hours = weather_data[:hourly][:data].first(8)
    hours.each {|hash| hash[:time] = format_time_hourly(hash[:time])}
  end

  def format_time_hourly(time)
    datetime = Time.at(time)
    datetime.strftime('%l %p').strip
  end

  def daily_group(weather_data)
    days = weather_data[:daily][:data].first(5)
    days.each do |hash|
      hash[:time] = format_time_daily(hash[:time])
      hash[:precipProbability] = format_precip_prob(hash[:precipProbability])
    end
  end

  def format_precip_prob(num)
    percent = (num * 100).round(0)
    "#{percent}%"
  end

  def format_time_daily(time)
    datetime = Time.at(time)
    datetime.strftime('%A')
  end
end
