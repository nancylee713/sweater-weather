class ForecastDecorator < SimpleDelegator
  def initialize(forecast)
    @forecast = super(forecast)
  end

  def address
    @forecast.location.formatted_address
  end

  def current_time
    time = Time.at(@forecast.current_time)
    time.strftime("%I:%M %p, %m/%d")
  end

  def summaries
    { today_sum: @forecast.today_summary,
      tonight_sum: @forecast.hourly_group.select {|x| x[:time] == tonight_timestamp}[0][:summary]
    }
  end

  def hourly_group
    format_hourly_forecast
  end

  def daily_group
    format_daily_forecast
  end

  private
  def tonight_timestamp
    @forecast.hourly_time + 21600  # 6 hours later
  end


  def format_time_hourly(time)
    datetime = Time.at(time)
    datetime.strftime('%l %p').strip
  end

  def format_precip_prob(num)
    percent = (num * 100).round(0)
    "#{percent}%"
  end

  def format_time_daily(time)
    datetime = Time.at(time)
    datetime.strftime('%A')
  end

  def format_hourly_forecast
    @forecast.hourly_group.each {|hash| hash[:time] = format_time_hourly(hash[:time])}
  end

  def format_daily_forecast
    @forecast.daily_group.each do |hash|
      hash[:time] = format_time_daily(hash[:time])
      hash[:precipProbability] = format_precip_prob(hash[:precipProbability])
    end
  end
end
