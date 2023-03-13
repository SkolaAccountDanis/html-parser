class Router

  attr_reader :routes
  def initialize
    @routes = []
  end

  def add_route(verb, path, &block)
    @routes << [verb, path]
  end

  def match_route(request)
    i = 0
    while request.length >= i
      if @routes[i] == request[i]
        p @routes
        p request
      end  
      i += 1
    end
  end
end

router = Router.new

router.add_route('get', '/hello') do
  "Hello, World"
end

router.add_route('get', '/senap') do
  "Not this one"
end

p router
router.match_route({verb: "GET", resource: "/hello"})

router.match_route({verb: "GET", resource: "/banan"})