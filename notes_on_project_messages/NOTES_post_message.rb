# post_message.rb

require "net/http"

puts ""
print "Who do you want to message? "
to = gets.chomp

print "Who are you? "
from = gets.chomp

print "Your message: "
content = gets.chomp

puts ""
print "Sending message..."

# uri = URI("http://#{to}-messages.herokuapp.com")
uri = URI("http://localhost:9292/")

# TODO: Post the message to the server
# Good resources include:
## http://ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/Net/HTTP.html
## http://www.rubyinside.com/nethttp-cheat-sheet-2940.html
response = Net::HTTP.post_form(uri, "from" => from,
                                    "to" => to,
                                    "content" => content)

if response.body == "success"
  puts "done!"
else
  puts "Oops, something went wrong :("
end

puts ""
