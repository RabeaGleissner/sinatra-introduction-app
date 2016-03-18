require 'sinatra'
require 'haml'

class IntroductionApp < Sinatra::Base
  enable :sessions

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
    @name = session["name"]
    @country = session["country"]
    @animal = session["animal"]
    haml :summary
  end
end
