ENV['RACK_ENV'] = 'test'

require_relative '../lib/introduction_app'
require 'rspec'
require 'rack/test'


describe 'IntroductionApp' do
  include Rack::Test::Methods

  def app
    IntroductionApp.new
  end

  it "gets the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Welcome to IntroduceME")
  end
end

