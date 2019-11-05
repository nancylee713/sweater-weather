require 'rails_helper'

describe 'Road Trip' do
  let(:user_attributes) { { email: 'whatever@example.com', password: 'password', password_confirmation: 'password' } }
  let(:login_attributes) { { email: 'whatever@example.com', password: 'password' } }

  let(:trip_attributes) {
    {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }

  let(:invalid_trip_attributes) {
    {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "invalid"
    }
  }

  before(:each) do
    user = User.create(user_attributes)
    post '/api/v1/users', params: user_attributes
    post '/api/v1/sessions', params: login_attributes
  end

  it 'can return forecast and travel info' do
    post '/api/v1/road_trip', params: trip_attributes

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    binding.pry
  end

  xit 'returns 401 status code when no API key or an incorrect key is given' do
    post '/api/v1/road_trip', params: invalid_trip_attributes

    expect(response.status).to eq(401)

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to eq('Invalid key. Please try again.')
  end
end
