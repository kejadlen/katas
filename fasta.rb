require 'delegate'
require 'open-uri'

class Sequence < DelegateClass(String)
  attr_reader :id

  def initialize(id, data)
    @id = id

    super(data)
  end
end

class FASTA < DelegateClass(Array)
  UNIPROT = 'http://www.uniprot.org/uniprot/%s.fasta'

  def self.from_uniprot(id)
    FASTA.new(open(UNIPROT % id).read)
  end

  def initialize(input)
    super(input.scan(/>([^\n]+)\n([^>]+)\n?/)
               .map {|k,v| Sequence.new(k, v.gsub(/\s+/, '')) })
  end

  def profile_matrix
    matrix = Hash.new {|h,k| h[k] = Hash.new(0) }
    each do |sequence|
      sequence.chars.each.with_index do |char,i|
        matrix[i][char] += 1
      end
    end
    matrix
  end

  def consensus
    matrix = profile_matrix
    length = matrix.keys.max
    (0..length).map {|i| matrix[i].to_a.max_by {|_,v| v }[0] }.join
  end

  def adjacency_list
    out = []
    each do |seq_a|
      reject {|seq_b| seq_a.id == seq_b.id }.each do |seq_b|
        out << [ seq_a.id, seq_b.id ] if yield seq_a, seq_b
      end
    end
    out
  end

  def longest_common_substring
    seq = max_by(&:length)
    seq.length.downto(1).each do |length|
      (0..(seq.length - length)).each do |i|
        substring = seq[i, length]

        return substring if all? {|seq| seq.include?(substring) }
      end
    end
  end
end
