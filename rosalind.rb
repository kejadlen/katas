class DNA
  attr_reader :raw

  def initialize(raw)
    @raw = raw
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
end

if __FILE__ == $0
  require 'pry'
  require 'pry-byebug'
  binding.pry
  exit # For Pry
end
