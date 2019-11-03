class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
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
end
