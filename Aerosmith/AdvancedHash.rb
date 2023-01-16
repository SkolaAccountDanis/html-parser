require 'pp'

example = <<~END
GET /hello HTTP/1.1
User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
Host: www.tutorialspoint.com
Accept-Language: en-us
Accept-Encoding: gzip, deflate
Connection: Keep-Alive
END


def parse_request(request)
    request_line = request
        .split('\n')
        .first
        .split(" ")
    headers = request
        .split("\n")
        .drop(1)
        .map{|header| header.split(": ")}
    parsed_request = {
        verb: request_line[0],
        resource: request_line[1],
        headers: headers.to_h
    }
    return parsed_request
end

pp parse_request(example)