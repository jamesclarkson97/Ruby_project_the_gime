require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

get '/classes' do
    # "Hello World"
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end