class BackgroundImageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :url
end
