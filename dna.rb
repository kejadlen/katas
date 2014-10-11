class DNA
  attr_reader :raw

  def initialize(raw)
    @raw = raw.gsub(/[^acgt]/i, '')
  end

  def nucleotide_count
    count = raw.chars.each.with_object(Hash.new(0)) do |nucleotide, count|
      count[nucleotide] += 1
    end
    count.values_at(*%w[A C G T])
  end

  def to_rna
    raw.tr(?T, ?U)
  end

  def reverse_complement
    raw.reverse.tr('ATCG', 'TAGC')
  end

  def gc_content
    gc = raw.chars.count {|nucleotide| nucleotide =~ /[GC]/i }
    100.0 * gc / raw.length
  end

  def ==(dna)
    raw == dna.raw
  end

  def hamming_distance(dna)
    raw.chars.zip(dna.raw.chars).count {|a,b| a != b }
  end
end

class FASTA
  attr_reader :dna

  def initialize(raw)
    @dna = Hash[raw.scan(/>([^\n]+)\n([^>]+)\n/).map {|k,v| [k, DNA.new(v)] }]
  end
end
