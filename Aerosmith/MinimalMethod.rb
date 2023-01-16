example = <<~END
GET /hello HTTP/1.1
User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
Host: www.tutorialspoint.com
Accept-Language: en-us
Accept-Encoding: gzip, deflate
Connection: Keep-Alive
END

def parse_request(request_string)
  request_string.split(" ")
end

request = parse_request(example)
#Minimal
p request #=> ["GET", "/hello"]
  