require 'rails_helper'

describe 'Account Creation' do
  let(:user_attributes) { { email: 'whatever@example.com', password: 'password', password_confirmation: 'password' } }

  it 'creates new user account' do

    post '/api/v1/users', params: user_attributes

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:api_key)
    expect(parsed[:api_key]).to eq('jgn983hy48thw9begh98h4539h4')
  end

  it 'returns 400 status code when given an invalid request' do
    post '/api/v1/users', params: {}

    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to eq('Invalid request. Please try again.')
  end
end
