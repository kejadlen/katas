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

def lexical_sort(alphabet, a, b)
  a = a.map {|c| alphabet.index(c) }
  b = b.map {|c| alphabet.index(c) }
  a <=> b
end

def permutations(alphabet, n)
  return alphabet if n == 1

  alphabet.flat_map {|char| permutations(alphabet, n-1).map {|p| "#{char}#{p}" }}
end

def lexv(alphabet, n)
  (1..n).flat_map {|i| permutations(alphabet, i)}.sort {|a, b| lexical_sort(alphabet, a.chars, b.chars) }
end
