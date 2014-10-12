require_relative 'dna'
require_relative 'fasta'
require_relative 'misc'

module Rosalind
  class Base
    attr_reader :input

    def initialize(input)
      @input = input.strip
    end

    def run
      raise NotImplementedError
    end
  end

  class LEXV < Base
    def run
      alphabet, n = input.split("\n")
      alphabet = alphabet.split(/\s+/)
      n = n.to_i

      puts lexv(alphabet, n)
    end
  end

  class PROT < Base
    def run
      puts RNA.new(input).to_protein_string
    end
  end

  class SUBS < Base
    def run
      s, t = input.split(/\s+/)
      indices = [ s.index(t) ]

      indices << s.index(t, indices.last+1) until indices.last.nil?
      indices.pop
      puts indices.map {|i| i+1 }.join(' ')
    end
  end

  class CONS < Base
    def run
      fasta = FASTA.new(input)

      puts fasta.consensus

      matrix = fasta.profile_matrix.to_a.sort.map(&:last)
      %w[ A C G T ].each do |nucleotide|
        puts "#{nucleotide}: #{matrix.map {|m| m[nucleotide]}.join(' ')}"
      end
    end
  end

  class GRPH < Base
    def run
      fasta = FASTA.new(input)
      puts fasta.adjacency_list.map {|neighbors| neighbors.join(' ') }.join("\n")
    end
  end

  class LCSM < Base
    def run
      fasta = FASTA.new(input)
      puts fasta.longest_common_substring
    end
  end
end

if __FILE__ == $0
  require 'pry' and binding.pry and exit if ARGV.empty?

  file = ARGV.shift
  problem = file[/rosalind_(\w+).txt/, 1]
  input = File.read(file)

  Rosalind.const_get(problem.upcase).new(input).run
end
