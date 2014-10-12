require_relative 'dna'

class FASTA
  attr_reader :dna

  def initialize(raw)
    @dna = Hash[raw.scan(/>([^\n]+)\n([^>]+)\n?/).map {|k,v| [k, DNA.new(v)] }]
  end

  def profile_matrix
    matrix = Hash.new {|h,k| h[k] = Hash.new(0) }
    dna.values.each do |dna|
      dna.raw.chars.each.with_index do |nucleotide,i|
        matrix[i][nucleotide] += 1
      end
    end
    matrix
  end

  def consensus
    matrix = profile_matrix
    length = matrix.keys.max
    (0..length).map {|i| matrix[i].to_a.max_by {|_,v| v }[0] }.join
  end

  def adjacency_list(n=3)
    array = dna.to_a
    out = []
    until array.empty?
      id_a, dna_a = array.shift
      neighbors = array.select do |_,dna_b|
        dna_a.suffix == dna_b.prefix || dna_a.prefix == dna_b.suffix
      end
      out.concat(neighbors.map {|id_b,_| [ id_a, id_b ] })
    end
    out
  end
end
