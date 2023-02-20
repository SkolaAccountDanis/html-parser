

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
                if file_ending == "css"
                    content_type = @mime_types["css"]
                    content = File.read(@resource)
                elsif file_ending == "js"
                    content_type = @mime_types["js"]
                    content = File.read(@resource)
                elsif file_ending == "png"
                    content_type = @mime_types["image"]
                    content = File.binread(@resource)
                elsif file_ending == "ico"
                    content_type = @mime_types["favicon"]
                    content = File.binread(@resource)
                elsif file_ending == "html"
                    content_type = @mime_types["html"]
                    content = File.read(@resource)
                end
                return content, status, content_type
            else
                return content = "Didnt find the resource", status = 404
            end

        end
end