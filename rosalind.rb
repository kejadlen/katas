def count_dna_nucleotides(dna)
  count = dna.chars.each.with_object(Hash.new(0)) do |nucleotide, count|
    count[nucleotide] += 1
  end
  count.values_at(*%w[A C G T])
end

def transcribe_dna_to_rna(dna)
  dna.tr(?T, ?U)
end

if __FILE__ == $0
  require 'pry'
  require 'pry-byebug'
  binding.pry
  exit # For Pry
end
