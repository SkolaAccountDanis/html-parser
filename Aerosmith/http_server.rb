require 'socket'
require_relative 'request_handler'
require_relative 'mimeTypes'

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
            sizeOfData = parseddata.size
            resource = "./files#{parseddata[:resource]}"

            @mimetypes = MimeTypes.new(resource)
            content, status , content_type = @mimetypes.contentType

            session.print "HTTP/1.1 #{status}\r\n"
            session.print "Content-Type: #{content_type}\r\n"
            session.print "Content-Length: #{content.size}\r\n"
            session.print "\r\n"
            session.print content
            session.close
        end
    end
end
server = HTTPServer.new(4567)
server.start