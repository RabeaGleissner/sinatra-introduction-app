ENV['RACK_ENV'] = 'test'

require_relative '../lib/introduction_app'
require 'rspec'
require 'rack/test'


describe 'IntroductionApp' do
  include Rack::Test::Methods

  def app
    IntroductionApp.new
  end

  it "displays the homepage" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to include("Welcome to IntroduceMANN")
  end

  it "redirects a post request to /name to /country" do
    post '/name'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'country'
  end

  it "displays country page with a comment about name" do
    get '/country', {}, {'rack.session' => {'name' => 'Jon'}}
    expect(last_response).to be_ok
    expect(last_response.body).to include('Jon')
  end

  it "redirects a post request to /country to /animal route" do
    post '/country'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'animal'
  end

  it "displays animal page with a comment about country" do
    get '/animal', {}, {'rack.session' => {'country' => 'USA'}}
    expect(last_response).to be_ok
    expect(last_response.body).to include("USA")
  end

  it "redirects a post request to the route /animal to /summary" do
    post '/animal'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'summary'
  end

  it 'displays the summary page with user data' do
    get '/summary', {}, {'rack.session' => {'name' => 'John Doe', 'country' => 'US', 'animal' => 'T-Rex'}}
    expect(last_response.body).to include("John Doe", "US", "T-Rex")
  end
end

