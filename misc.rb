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
             when 0
               1
             when 1..2
               1
             when 3
               2
             else
               h[[n-1,m]] + h[[n-2,m]] - h[[n-4,m]]
             end
end
