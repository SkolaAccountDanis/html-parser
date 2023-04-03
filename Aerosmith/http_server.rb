require 'socket'
require_relative 'request_handler'
require_relative 'mimeTypes'
require_relative 'response'
require_relative 'router'

class HTTPServer

    def initialize(port)
        @port = port
        @request_handler = RequestHandler.new
        @routes = []
    end

    
    def add_route(verb, path, &block)
        @routes << {verb: verb, resource: path, block: block}
    end


    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end

            parseddata = @request_handler.parse_request(data)
            resource = "./files#{parseddata[:resource]}"

            @mimetypes = MimeTypes.new(resource)
            content, status, content_type = @mimetypes.contentType
            if status == 200
                Response.new(status, content, content_type, session)
            elsif status == 404
                path = parseddata[:resource]
                status = 200
                # p resource
                # p @routes
                # p block
                content_type = 'text/html'
                @routes.filter{|route| route[:verb] == "get" && route[:resource] == path}.each do |route|
                    Response.new(status, route[:block].call, content_type, session)   
                end
            end
        end
    end
end

server = HTTPServer.new(4567)


server.add_route('get', '/hello') do
    "<h1>Hello</h1>"
end

server.add_route('get', '/print') do
    "<h1>#{2+4}</h1>"
end


server.start