Rabbits = Hash.new do |h,(n,k)|
  h[[n,k]] = case n
             when 0..2
               1
             else
               h[[n-1,k]] + k*h[[n-2,k]]
             end
end

MortalRabbits = Hash.new do |h,(n,m)|
  h[[n,m]] = case n
             when -m..0
               [0, 0]
             when 1
               [1, 0]
             else
               [ h[[n-1,m]][1], # new rabbits
                 h[[n-1,m]][0] + h[[n-1,m]][1] - h[[n-m,m]][0] ]
             end
end
