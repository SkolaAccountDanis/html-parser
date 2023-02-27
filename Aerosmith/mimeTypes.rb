

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
            if File.exists?(@resource)
                status = 200
                case file_ending
                when "css"
                    content_type = @mime_types["css"]
                    content = File.read(@resource)
                when "js"
                    content_type = @mime_types["js"]
                    content = File.read(@resource)  
                when "png"
                    content_type = @mime_types["image"]
                    content = File.binread(@resource)  
                when "ico"
                    content_type = @mime_types["favicon"]
                    content = File.binread(@resource)    
                when "html"
                    content_type = @mime_types["html"]
                    content = File.read(@resource)   
                else
                    return content = "Didnt find the resource", status = 404
                end
            end

        end
end