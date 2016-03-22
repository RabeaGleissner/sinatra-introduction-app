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

  get "/home/:error" do
    @error_message = true
    haml :home
  end

  post "/name" do
    name = params[:name]
    if name != ""
      session[:name] = name
      redirect '/country'
    else
      redirect '/home/error'
    end
  end

  get "/country" do
    @name = session["name"]
    haml :country
  end

  get "/country/:error" do
    @error_message = true
    @name = session["name"]
    haml :country
  end

  post "/country" do
    country = params[:country]
    if country != ""
      session[:country] = country
      redirect '/animal'
    else
      redirect 'country/error'
    end
  end

  get "/animal" do
    @country = session["country"]
    haml :animal
  end

  get "/animal/:error" do
    @error_message = true
    @country = session["country"]
    haml :animal
  end

  post "/animal" do
    animal = params[:animal]
    if animal != ""
      session[:animal] = animal
      redirect '/summary'
    else
      redirect 'animal/error'
    end
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
