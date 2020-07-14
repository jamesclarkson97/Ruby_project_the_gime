require_relative( "../models/member.rb" )
require_relative( "../models/gym_class.rb" )
require_relative( "../models/enrollment.rb" )
require("pry-byebug")

Enrollment.delete_all()
Member.delete_all()
GymClass.delete_all()

member1 = Member.new({
    "first_name" => "Homer",
    "last_name" => "Simpson",
    "active" => true
})
member1.save()

gym_class1 = GymClass.new({
    "name" => "Mountain Climbing for Beginners",
    "max_capacity" => "10"
})
gym_class1.save()

enrollment1 = Enrollment.new({
    "member_id" => member1.id,
    "gym_class_id" => gym_class1.id
})
enrollment1.save()

binding.pry
nil