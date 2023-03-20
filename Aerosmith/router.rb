class Router

  attr_reader :routes
  def initialize
    @routes = []
  end

  def add_route(verb, path, &block)
    @routes << {verb: verb, resource: path, block: block}
  end

  def match_route(request)
    route = @routes.find {|route| route[:verb] == request[:verb] and route[:resource] == request[:resource] }
    if route
      p route[:block].call 
    else
      p "There is no route"
    end
  end
end

# router = Router.new

# router.add_route('get', '/hello') do
#   p 2+4
# end

# router.add_route('get', '/senap') do
#   p "Not this one"
# end

# router.add_route('get', '/banan') do
#   p "ifeho"
# end


# router.match_route({verb: 'get', resource: '/hello'})

# router.match_route({verb: 'get', resource: '/banan'})

# router.match_route({verb: 'get', resource: '/senap'})

# router.match_route({verb: 'post', resource: '/senap/update'})