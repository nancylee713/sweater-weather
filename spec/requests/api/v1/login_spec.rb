require 'rails_helper'

describe 'Login' do
  let(:user_attributes) { { email: 'whatever@example.com', password: 'password', api_key: 'test' } }

  it 'can login' do
    user = User.create(user_attributes)
    post '/api/v1/sessions', params: user_attributes

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed).to have_key(:api_key)
    expect(parsed[:api_key]).to eq('jgn983hy48thw9begh98h4539h4')
  end

  it 'returns 400 status code when given a nonexistent email' do
    user = User.create(user_attributes)
    post '/api/v1/sessions', params: { email: 'not_a_user@example.com', password: 'password' }

    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to eq('Email not found in the system. Please register first.')
  end

  it 'returns 400 status code when given an incorrect password' do
    user = User.create(user_attributes)
    post '/api/v1/sessions', params: { email: 'whatever@example.com', password: 'wrong_password' }

    expect(response.status).to eq(400)

    parsed = JSON.parse(response.body, symbolize_names: true)
    expect(parsed).to have_key(:error)
    expect(parsed[:error]).to eq('Incorrect password. Please try again.')
  end
end
