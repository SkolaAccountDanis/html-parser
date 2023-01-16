
example = <<~END
GET /hello HTTP/1.1
User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
Host: www.tutorialspoint.com
Accept-Language: en-us
Accept-Encoding: gzip, deflate
Connection: Keep-Alive
END



# Minimal Method
# def parse_request(request_string)
#   request_string.split(" ")
# end

# request = parse_request(example)
# Minimal Method 

### Examples of what the method can return

#Minimal
p request #=> ["GET", "/hello"]
  
#Small Hash
p request #=> {:verb => :get, :resource => "/hello"}
  
#"Simple" Object
p request #=> <HTTPRequest @verb=:get, @resource="/hello">
  
#Advanced Hash
p request #=> {:verb => :get, :resource => "/hello",
# :headers => [
# "User-Agent" => "Mozilla/4.0 (compatible; MSIE5.01; Windows NT)"
# "Host" => "www.tutorialspoint.com&quot;
# "Accept-Language" => "en-us"
# "Accept-Encoding" => ["gzip", "deflate"]
# ]
#}