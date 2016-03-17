require "sinatra"

class IntroductionApp < Sinatra::Base
  get "/" do
    "Hello "
  end
end

