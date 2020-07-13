require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/members_controller')
require_relative('controllers/gym_classes_controller')
require_relative('controllers/enrollments_controller')
also_reload('models/*')

get '/' do
    erb(:index)
end

get '/classes' do
    "Hello World"
    # @gym_classes = GymClasses.all()
    # erb(:"gym_classes/index")
end