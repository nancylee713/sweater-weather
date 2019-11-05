class RoadTripFacade
  def initialize(info)
    @origin = info[:origin]
    @destination = info[:destination]
  end

  def road_trip_data
    RoadTrip.new(forecast_raw_data, time)
  end

  private

  attr_reader :origin, :destination

  def google_direction_service
    GoogleDirectionService.new(origin, destination)
  end

  def google_direction_data
    google_direction_service.get_direction
  end

  def time
    google_direction_data[:duration]
  end

  def time_machine_service
    TimeMachineService.new(google_direction_data, time)
  end

  def forecast_raw_data
    time_machine_service.get_data
  end
end
