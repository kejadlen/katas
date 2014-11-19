module Rosalind
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

  def self.lexical_sort(alphabet, a, b)
    a = a.map {|c| alphabet.index(c) }
    b = b.map {|c| alphabet.index(c) }
    a <=> b
  end

  def self.permutations(alphabet, n)
    return alphabet if n == 1

    alphabet.flat_map {|char| permutations(alphabet, n-1).map {|p| "#{char}#{p}" }}
  end

  def self.lexv(alphabet, n)
    (1..n).flat_map {|i| permutations(alphabet, i)}.sort {|a, b| lexical_sort(alphabet, a.chars, b.chars) }
  end

  def self.iprb(k, m, n)
    total = (k + m + n).to_f
    mm = (m/total) * ((m-1)/(total-1))
    mn = (m/total) * (n/(total-1))
    nm = (n/total) * (m/(total-1))
    nn = (n/total) * ((n-1)/(total-1))
    recessive = mm*0.25 + mn*0.5 + nm*0.5 + nn
    1 - recessive
  end
end
