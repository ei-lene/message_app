# app.rb
 
# lookup sinatra reloader
 
# 1. The post_message.rb must submit a POST request to localhost:9292
# (this running sinatra application). It should post
# to, from, content variables along with the request.
# Lookup how to submit POST requests using net/http
# and how to submit data along with that request
 
# 2. Build out the post '/' routes below in this file
# to take the incoming data and create a message from it
# you will need to lookup some basics on datamapper
# the getting started guide is a good place to start
# and you will need to lookup how to get POST
# data out of the request in sinatra
 
# 3. You need to edit messages.erb to iterate
# through all the @messages and print out the
# data
require 'sinatra'
require 'sinatra/reloader'
# Allows the localhost to update automatically without shutting down and restarting
# to install:--> gem install sinatra-contrib

require 'data_mapper'
require 'dm-postgres-adapter'
 
ENV['DATABASE_URL'] ||= 'postgres://e:@localhost/messages_app'
 
DataMapper.setup(:default, ENV['DATABASE_URL'])
 
get '/' do
  @messages = Message.all
  erb :messages
end
 
get '/migrate' do
  DataMapper.auto_migrate!
  "Database migrated! All tables reset."
end
 
post '/' do
# TODO: Read the incoming message, save it to the database

  message = request.post # request is a method that calls on a variable
  # can also try using @params or params (see the code deep in binding.pry)
  # @message = Message.create(
  #   :from => message["from"],
  #   :to => message["to"],
  #   :content => message["content"]
  #   )
  params.delete("to")                # Deletes the 'to' key
  @message = Message.create(params) # Can do mass assignment by calling params which is a full hash

  # Because mass assignments are allowed (params can be assigned),
  ## it must mean that the initialize method looks something like the following:
  # def initialize(opts={})
  #   options.each do |attribute,value|
  #     @attribute = value 
  #   end
  # end

  redirect '/'  # This redirects to the page again
  
  "success"

end
 
class Message
include DataMapper::Resource
# Documentation: http://datamapper.org/ 
# Property is a class method. 
property :id, Serial # Auto-increment integer id
property :from, String # A short string of text
property :to, String #A short string of text
property :content, Text # A longer text block
property :created_at, DateTime # Auto assigns data/time
end



 
DataMapper.finalize
DataMapper.auto_upgrade!