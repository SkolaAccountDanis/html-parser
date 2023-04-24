require_relative 'lib/http_server'

server = HTTPServer.new(4567)

server.add_route('get', '/hello') do
    "<h1>Hello</h1>"
end

server.add_route('get', '/print') do
    "<h1>#{2+4}</h1>"
end

server.add_route('get', '/test/:term1/:term2') do |term1, term2|
    "<h1>#{term1.to_i + term2.to_i}<h1>"
end


server.add_route('get', '/test/testigen/:term1/:term2') do |term1, term2|
    "<h1>#{term1 + term2}<h1>"
end

server.start