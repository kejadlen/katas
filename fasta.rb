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
    out = []
    dna.each do |id_a,dna_a|
      dna.reject {|id_b,_| id_a == id_b }.each do |id_b,dna_b|
        out << [id_a, id_b] if dna_a.suffix(n) == dna_b.prefix(n)
      end
    end
    out
  end

  def longest_common_substring
    a_dna = dna.values.max_by(&:length)
    a_dna.length.downto(1).each do |length|
      (0..(a_dna.length - length)).each do |i|
        substring = a_dna[i, length]

        return substring if dna.values.all? {|dna| dna.include?(substring) }
      end
    end
  end
end
