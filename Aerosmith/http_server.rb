require 'socket'
require_relative 'request_handler'
require_relative 'mimeTypes'
require_relative 'response'
require_relative 'router'

class HTTPServer

    def initialize(port)
        @port = port
        @request_handler = RequestHandler.new
    end

    def start
        server = TCPServer.new(@port)
        puts "Listening on #{@port}"

        while session = server.accept
            data = ""
            while line = session.gets and line !~ /^\s*$/
                data += line
            end
            puts "RECEIVED REQUEST"
            puts "-" * 40
            puts data
            puts "-" * 40 

            parseddata = @request_handler.parse_request(data)
            resource = "./files#{parseddata[:resource]}"

            @mimetypes = MimeTypes.new(resource)
            content, status , content_type = @mimetypes.contentType
            Response.new(status, content, content_type, session)
        end
    end
end

server = HTTPServer.new(4567)
server.start

Mysin.get(server) do
    p "wowoooork"
end

