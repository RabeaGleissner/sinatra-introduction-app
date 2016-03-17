require 'sinatra'
require 'haml'

class IntroductionApp < Sinatra::Base
  get "/" do
    haml :home
  end

  post "/country" do
    @name = params[:name]
    haml :country
  end

  post "/animal" do
    @country = params[:country]
    haml :animal
  end

  post "/summary" do
    @name
    @country
    @animal = params[:animal]
    haml :summary
  end
end
