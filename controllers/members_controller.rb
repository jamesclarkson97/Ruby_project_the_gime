require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/member.rb')
also_reload('../models/*')

# INDEX
get '/members' do
    @members = Member.all()
    erb(:"members/index")
end

# NEW
get '/members/new' do
    erb(:"members/new")
end

# SHOW
get '/members/:id' do
    @member = Member.find(params['id'].to_i)
    erb(:"members/show")
end

# CREATE
post '/members' do
    @member = Member.new(params)
    @member.save
    @members = Member.all()
    erb(:"members/index")
end

# EDIT
get '/members/:id/edit' do
    @member = Member.find(params['id'].to_i)
    erb(:"members/edit")
end

# DESTROY
post '/members/:id/delete' do
    Member.delete(params['id'].to_i)
    redirect to("/members")
end

# UPDATE
post '/members/:id' do
    @member = Member.new(params)
    @member.update
    @members = Member.all()
    erb(:"members/index")
end