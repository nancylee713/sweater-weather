class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attribute :id

  attribute :overview do |data|
    {
      location: data.location,
      current_time: data.current_time,
      current_summary: data.current_sum,
      icon: data.icon,
      temp: data.current_temp,
      temp_high: data.temp_high,
      temp_low: data.temp_low
    }
  end

  attribute :details do |data|
    {
      feels_like: data.feels_like,
      humidity: data.humidity,
      visibility: data.visibility,
      uvIndex: data.uvIndex,
      summaries: data.summaries
    }
  end

  attribute :hourly_forecast do |data|
    data.hourly_forecast.map! {|hour| hour.slice(:time, :temperature)}
  end

  attribute :daily_forecast do |data|
    data.daily_forecast.map! {|day| day.slice(:time, :summary, :precipProbability, :precipType, :temperatureHigh, :temperatureLow)}
  end
end
