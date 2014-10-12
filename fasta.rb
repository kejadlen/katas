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
end

