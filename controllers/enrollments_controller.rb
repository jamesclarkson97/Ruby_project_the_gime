require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/enrollment.rb')
require_relative('../models/member.rb')
require_relative('../models/gym_class.rb')
also_reload('../models/*')