require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/enrollment.rb')
require_relative('../models/member.rb')
require_relative('../models/gym_class.rb')
also_reload('../models/*')

# NEW
get '/enrollment/:id' do
    @gym_class = GymClass.find(params['id'].to_i)
    if @gym_class.check_availability == true
        @members = Member.all()
        erb(:"enrollments/new")
    else
        erb(:"enrollments/unsuccesful")
    end
end

# CREATE
post '/enrollment' do
    enrollment = Enrollment.new(params)
    enrollment.save
    @gym_class = enrollment.gym_class()
    erb(:"gym_classes/show")
end