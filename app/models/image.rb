class Image
  attr_reader :id, :url

  def initialize(data)
    @id = 0
    @url = data[:results].first[:urls][:full]
  end
end
