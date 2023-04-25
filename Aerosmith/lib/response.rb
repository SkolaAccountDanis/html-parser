
require 'debug'

#class Response
# 
# Handles the response for status, content, content-type and session
class Response
    
    #initializes the verbs aswell as runs the code 
    # 
    # @param status [Integer] the status of the request
    # @param content [String] the content of the request
    # @param content_type [String] the mimetype of the content in the reqeust
    # @param session [String] the socket used for the server
    # @return [void]
    def initialize(status, content, content_type, session)
        @status = status
        @content = content
        @content_type = content_type
        @session = session
        run()
    end

    # Sends a HTTP response to the client
    # 
    # @return [void]
    def run
        @session.print "HTTP/1.1 #{@status}\r\n"
        @session.print "Content-Type: #{@content_type}\r\n"
        @session.print "Content-Length: #{@content.size}\r\n"
        @session.print "\r\n"
        @session.print @content
        @session.close

    end
end