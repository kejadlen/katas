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
end
