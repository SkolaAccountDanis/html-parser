
class Mysin
    
    def initialize
        @hash = {}   
    end

    def get(url, &block)
        if block_given?
            @hash[url] = block
        end
    end

    def call(env)
        @request_url = env['REQUEST_URI']
    end

    if @hash.key?(@request_url)
        response = @hash[@request_url].call
        [200, [response]]
    else
        [404, ['Not Found']]
    end  
end


# def get(path)
#     my_hash = Hash.new()
    
#     my_block = Proc.new do
#         puts "pllzzzzwork"
#     end
    
#     my_hash[path] = my_block
#     my_hash[path].call
# end