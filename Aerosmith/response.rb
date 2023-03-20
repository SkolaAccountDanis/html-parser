

class Response
    def initialize(status, content, content_type, session)
        @status = status
        @content = content
        @content_type = content_type
        @session = session
        run()
    end

    def run
        @session.print "HTTP/1.1 #{@status}\r\n"
        @session.print "Content-Type: #{@content_type}\r\n"
        @session.print "Content-Length: #{@content}\r\n"
        @session.print "\r\n"
        @session.print @content
        @session.close

    end
end