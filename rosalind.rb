require_relative 'dna'
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
end

if __FILE__ == $0
  file = ARGV.shift
  problem = file[/rosalind_(\w+).txt/, 1]
  input = File.read(file)

  Rosalind.const_get(problem.upcase).new(input).run
end
