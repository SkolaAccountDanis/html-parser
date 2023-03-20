

class MimeTypes

    def initialize(resource)
        @resource = resource
        @mime_types = {
            "css" => "text/css",
            "js" => "application/javascript",
            "html" => "text/html",
            "image" => "image/*",
            "favicon" => "image/x-icon"
        }
    end

   
    def contentType
        file_ending = @resource.split(".").last
        content = nil
        status = 404
        if File.exists?(@resource)
            case file_ending
            when "css"
                content_type = @mime_types["css"]
                content = File.read(@resource)
                status = 200
            when "js"
                content_type = @mime_types["js"]
                content = File.read(@resource)  
                status = 200
            when "png"
                content_type = @mime_types["image"]
                content = File.binread(@resource)  
                status = 200
            when "ico"
                content_type = @mime_types["favicon"]
                content = File.binread(@resource)    
                status = 200
            when "html"
                content_type = @mime_types["html"]
                content = File.read(@resource)   
                status = 200
            end
            return content, status, content_type 
        else
            return content, status, content_type = nil
        end

    end
end