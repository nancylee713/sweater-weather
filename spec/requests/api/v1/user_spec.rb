require 'rails_helper'

describe 'Account Creation' do
  let(:user_attributes) { { email: 'whatever@example.com', password: 'password', password_confirmation: 'password' } }

  it 'creates new user account' do

    post '/api/v1/users', params: user_attributes

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:data].first[:attributes].count).to eq(4)
    expect(parsed[:data].first[:attributes]).to have_key(:email)
    expect(parsed[:data].first[:attributes]).to have_key(:password)
    expect(parsed[:data].first[:attributes]).to have_key(:password_confirmation)
  end
end
