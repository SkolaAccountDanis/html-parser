# class Array

#     def get(&block)
#         if block_given?
#             i = 0
#             while i < self.length
#                 yield(self[i], "potato")
#                 i += 1
#             end
#         else
#             p "no block has been given :/"
#         end
#     end
# end

# num = [1, 2, 3]

# num.get do |number, word| 
#     puts word * number 
# end

path = "add/term1/term2"

def get(path)
    if path.include? "term1"
        p "plzwork"
end
