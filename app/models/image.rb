class Image
  attr_reader :id, :url

  def initialize(data)
    @id = 0
    @url = data[:results].shuffle.first[:urls][:full]
  end
end
