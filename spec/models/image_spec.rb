require 'rails_helper'

RSpec.describe Image do
  before(:each) do
    json_data = {
      "results": [
        {
          "urls": {
            "full": "https://images.unsplash.com/photo-1570585429632-e8b74372a3ed?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjk5NjI0fQ",
          }
        }
      ]
    }
    @image = Image.new(json_data)
  end

  it 'is created with image' do
    expect(@image).to be_a(Image)
  end

  it "can return url" do
    expected = "https://images.unsplash.com/photo-1570585429632-e8b74372a3ed?ixlib=rb-1.2.1&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjk5NjI0fQ"

    expect(@image.url).to eq(expected)
  end
end
