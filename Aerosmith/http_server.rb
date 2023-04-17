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
        regex_string = path.gsub(/:\w+/, "(.+)")
        regex_path = Regexp.new(regex_string)#omvandla till regexp
        @routes << {verb: verb, resource: regex_path, block: block}
    end

    def match_route(request)
        match = @routes.find {|route| request.match(route[:resource])}
        if match
            
        end
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
                i = 2
                params = []
                while i < path.split("/").length
                    params << path.split("/")[i]
                    i += 1  
                    p params
                end

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

server.add_route('get', '/test/:term1/:term2') do |term1, term2|
    "<h1>#{term1 + term2}<h1>"
end


server.add_route('get', '/test/testigen/:term1/:term2') do |term1, term2|
    "<h1>#{term1 + term2}<h1>"
end

server.start