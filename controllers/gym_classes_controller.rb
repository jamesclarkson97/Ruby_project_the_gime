require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

get '/classes' do
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end

get '/classes/:id' do
    @gym_class = GymClass.find(params['id'].to_i)
    erb(:"gym_classes/show")
end