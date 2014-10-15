require_relative 'dna'
require_relative 'fasta'
require_relative 'misc'

module Rosalind
  PROBLEMS = {}

  def self.problem(name, &block)
    PROBLEMS[name.to_s] = block
  end

  problem :lexv do |input|
    alphabet, n = input.split("\n")
    alphabet = alphabet.split(/\s+/)
    n = n.to_i

    puts lexv(alphabet, n)
  end

  problem :prot do |input|
    puts RNA.new(input).to_protein_string
  end

  problem :subs do |input|
    s, t = input.split(/\s+/)
    indices = [ s.index(t) ]

    indices << s.index(t, indices.last+1) until indices.last.nil?
    indices.pop
    puts indices.map {|i| i+1 }.join(' ')
  end

  problem :cons do |input|
    fasta = FASTA.new(input)

    puts fasta.consensus

    matrix = fasta.profile_matrix.to_a.sort.map(&:last)
    %w[ A C G T ].each do |nucleotide|
      puts "#{nucleotide}: #{matrix.map {|m| m[nucleotide]}.join(' ')}"
    end
  end

  problem :grph do |input|
    fasta = FASTA.new(input)
    puts fasta.adjacency_list.map {|neighbors| neighbors.join(' ') }.join("\n")
  end

  problem :lcsm do |input|
    fasta = FASTA.new(input)
    puts fasta.longest_common_substring
  end

  problem :mprt do |input|
    input.split("\n").each do |id|
      fasta = FASTA.from_uniprot(id)

      motifs = Protein.new(fasta[0]).motifs('N{P}[ST]{P}')
      next if motifs.empty?

      puts id
      puts motifs.join(' ')
    end
  end

  problem :mrna do |input|
    puts Protein.new(input).rna_count
  end

  problem :orf do |input|
    fasta = FASTA.new(input)
    dna = DNA.new(fasta[0])
    puts dna.to_proteins.join("\n")
  end
end

if __FILE__ == $0
  if ARGV.empty?
    require 'pry'
    binding.pry
    exit
  end

  file = ARGV.shift
  problem = file[/rosalind_(\w+).txt/, 1]
  input = File.read(file)

  # Rosalind.const_get(problem.upcase).new(input).run
  Rosalind::PROBLEMS[problem.downcase][input]
end
