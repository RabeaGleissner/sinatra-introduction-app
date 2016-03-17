ENV['RACK_ENV'] = 'test'

require_relative '../lib/introduction_app'
require 'rspec'
require 'rack/test'


describe 'IntroductionApp' do
  include Rack::Test::Methods

  def app
    IntroductionApp.new
  end

  it "says hello" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq('Hello ')
  end
end

