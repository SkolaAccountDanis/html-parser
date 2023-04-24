class RequestHandler
  
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
        version: request_line[2],
        headers: headers.to_h
    }
    return parsed_request
  end

end