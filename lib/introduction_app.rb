require 'sinatra'
require 'haml'
require_relative 'person'

class IntroductionApp < Sinatra::Base
  use Rack::Session::Pool

  configure do
    @@people ||= []
  end

  get "/" do
    haml :home
  end

  post "/name" do
    session[:name] = params[:name]
    redirect '/country'
  end

  get "/country" do
    @name = session["name"]
    haml :country
  end

  post "/country" do
    session[:country] = params[:country]
    redirect '/animal'
  end

  get "/animal" do
    @country = session["country"]
    haml :animal
  end

  post "/animal" do
    session[:animal] = params[:animal]
    redirect '/summary'
  end

  get "/summary" do
    @animal = session["animal"]
    @@people << Person.new(session["name"], session["country"], @animal)
    @people = @@people
    haml :summary
  end

  get '/styles/styles.css' do
    scss :styles
  end
end
