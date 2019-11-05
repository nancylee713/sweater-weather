class RoadTripFacade
  def initialize(info)
    @origin = info[:origin]
    @destination = info[:destination]
  end

  def google_direction_data
    google_direction_service.get_direction
  end

  private

  def google_direction_service
    GoogleDirectionService.new(@origin, @destination)
  end
end
