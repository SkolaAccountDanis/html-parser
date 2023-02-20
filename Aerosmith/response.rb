

class Response
    def initialize(mime_types)
        @mime_types = mime_types
        run()
    end

    def run
        
        file_ending = resource.split(".").last
        if File.exists?(resource)
            status = 200
            if file_ending == "css"
                content_type = mime_types["css"]
                content = File.read(resource)
            elsif file_ending == "js"
                content_type = mime_types["js"]
                content = File.read(resource)
            elsif file_ending == "png"
                content_type = mime_types["image"]
                content = File.binread(resource)
            elsif file_ending == "ico"
                content_type = mime_types["favicon"]
                content = File.binread(resource)
            elsif file_ending == "html"
                content_type = mime_types["html"]
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