require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/enrollment.rb')
require_relative('../models/member.rb')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

# NEW
get '/classes/:id/enroll' do
    @gym_class = GymClass.find(params['id'].to_i)
    @members = Member.all()
    erb(:"enrollments/new")
end

# CREATE
# post '/classes/:id' do
#     @enrollment = Enrollment.new(params)
#     @enrollment.save
#     @gym_classes = GymClass.all()
#     erb(:"gym_classes/index")
# end