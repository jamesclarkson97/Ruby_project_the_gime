require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

get '/classes' do
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end

get '/classes/new' do
    erb(:"gym_classes/new")
end

get '/classes/:id' do
    @gym_class = GymClass.find(params['id'].to_i)
    erb(:"gym_classes/show")
end

post '/classes' do
    @gym_class = GymClass.new(params)
    @gym_class.save
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end