require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

# INDEX
get '/classes' do
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end

# NEW
get '/classes/new' do
    erb(:"gym_classes/new")
end

# SHOW
get '/classes/:id' do
    @gym_class = GymClass.find(params['id'].to_i)
    erb(:"gym_classes/show")
end

# CREATE
post '/classes' do
    @gym_class = GymClass.new(params)
    @gym_class.save
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end

# EDIT
get '/classes/:id/edit' do
    @gym_class = GymClass.find(params['id'].to_i)
    erb(:"gym_classes/edit")
end

# DESTROY
post '/classes/:id/delete' do
    GymClass.delete(params['id'].to_i)
    redirect to("/classes")
end

# UPDATE
post '/classes/:id' do
    @gym_class = GymClass.new(params)
    @gym_class.update
    @gym_classes = GymClass.all()
    erb(:"gym_classes/index")
end