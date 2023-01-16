require 'socket'
require_relative 'request_handler'

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

            # #Er HTTP-PARSER tar emot "data" 
            parseddata = @request_handler.parse_request(data)
            resource = "./html#{parseddata[:resource]}"
            p parseddata
            p resource            

            #Sen kolla om resursen (filen finns)
            if File.exists?(resource)
                status = 200
                html = File.read(resource)
            else
                status = 404
                html = "Didnt find the resource"
            end

            session.print "HTTP/1.1 #{status}\r\n"
            session.print "Content-Type: text/html\r\n"
            session.print "\r\n"
            session.print html
            session.close
        end
    end
end

server = HTTPServer.new(4567)
server.start