class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :estimated_travel_time, :eta, :temperature, :summary
end
