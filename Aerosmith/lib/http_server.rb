require 'socket'
require_relative 'request_handler'
require_relative 'mimeTypes'
require_relative 'response'



# Class HTTPServer represents a HTTP server that listens to a port given, and responds
# to incoming requests with static files or user-defined routes
class HTTPServer

    # Initializes the port
    # 
    # 
    def initialize(port)
        @port = port
        @request_handler = RequestHandler.new
        @routes = []
    end

# Adds a route with verb, path and block
#
# @param verb [String] the HTTP Verb, `'get'` or `'post'`
# @param path [String] the HTTP Path, example "/test/1/2"
# @param block [Block] the code written in block by user in their route
    def add_route(verb, path, &block)
        regex_string = path.gsub(/:\w+/, "(.+)")
        regex_path = Regexp.new(regex_string)
        @routes << {verb: verb, resource: regex_path, block: block}
    end

    # Math route proved by request with route resource
    # 
    # @param request [String] the HTTP request, includes verb, path and block
    # @return [Hash, nil] returns hash if there is a match, or returns nil
    def match_route(request)
        return @routes.find {|route| request.match(route[:resource])}
    end

    # Starts the HTTPServer and listens for requests
    # 
    # Method runs indefinitely, handling requests as they arrive
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
                route = match_route(path)
                content_type = 'text/html'
                if route
                    params = route[:resource].match(path).captures
                    Response.new(status, route[:block].call(params), content_type, session)   
                else
                    status = 404
                    Response.new(status, "<h1>NOT FOUND</h1>",content_type, session)
                end
            end
        end
    end
end

