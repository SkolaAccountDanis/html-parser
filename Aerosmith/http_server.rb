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
            mime_types = {
                "css" => "text/css",
                "js" => "text/javascript",
                "html" => "text/html"
            }
            parseddata = @request_handler.parse_request(data)
            sizeOfData = parseddata.size
            resource = "./html#{parseddata[:resource]}"
            # p parseddata
            # p resource            
            # p sizeOfData

            #Sen kolla om resursen (filen finns)
            #kolla filändelsen med split
            #kan även kolla accept header i request
            #grillkorv.css
            #banan.korv.jpg.css
            file_ending = resource.split(".").last
            if File.exists?(resource)
                status = 200
                if file_ending == "css"
                    content_type = mime_types["css"]
                    content = File.read(resource)
                elsif file_ending == "html"
                    content_type = mime_types["html"]
                    content = File.read(resource)
                elsif file_ending == "js"
                    content_type = mime_types["js"]
                    content = File.read(resource)
                end
            else
                status = 404
                content = "Didnt find the resource"
            end


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