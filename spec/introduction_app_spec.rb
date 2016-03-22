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
    expect(last_response.body).to include('Welcome to IntroduceMANN')
  end

  it "redirects a post request with body to /name to /country" do
    post '/name', 'name' => 'Jon'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'country'
  end

  it "redirects a post request to /name with an empty body to the home error route" do
    post '/name', 'name'=> ''
    expect(last_response.location).to include '/home/error'
  end

  it "sets the name from params in the session and uses it in the country route" do
    post '/name', 'name' => 'Jon'
    get '/country'
    expect(last_response.body).to include 'Jon'
    expect(last_request.env['rack.session']['name']).to eql('Jon')
  end

  it "displays country page with a comment about name" do
    get '/country', {}, {'rack.session' => {'name' => 'Jon'}}
    expect(last_response).to be_ok
    expect(last_response.body).to include 'Jon'
  end

  it "redirects a post request to /country with a body to /animal route" do
    post '/country', 'country' => 'MyLand'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'animal'
  end

  it "redirects a post request to /country with an empty body to country error route" do
    post '/country', 'country' => ''
    expect(last_response).to be_redirect
    expect(last_response.location).to include '/country/error'
  end

  it "sets the country from params in the session and uses it in the animal route" do
    post '/country', 'country' => 'Germany'
    get '/animal'
    expect(last_response.body).to include 'Germany'
  end

  it "displays animal page with a comment about country" do
    get '/animal', {}, {'rack.session' => {'country' => 'USA'}}
    expect(last_response).to be_ok
    expect(last_response.body).to include 'USA'
  end

  it "redirects a post request to /animal with a body to /summary" do
    post '/animal', 'animal' => 'dog'
    expect(last_response).to be_redirect
    expect(last_response.location).to include 'summary'
  end

  it "redirects an empty post request to /animal to the animal error route" do
    post '/animal', 'animal' => ''
    expect(last_response).to be_redirect
    expect(last_response.location).to include '/animal/error'
  end

  it "sets the animal from params in the session cookie and uses it in the summary route" do
    post '/animal', 'animal' => 'dog'
    get '/summary'
    expect(last_response.body).to include 'dog'
  end

  it "displays the summary page with user data" do
    get '/summary', {}, {'rack.session' => {'name' => 'John Doe', 'country' => 'US', 'animal' => 'T-Rex'}}
    expect(last_response.body).to include('John Doe', 'US', 'T-Rex')
  end
end
