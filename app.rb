require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/members_controller')
require_relative('controllers/gym_classes_controller')
require_relative('controllers/enrollments_controller')

get '/' do
    erb(:index)
end