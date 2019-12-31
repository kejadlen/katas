class Protein < DelegateClass(String)
  MONOISOTOPIC_MASS = Hash[<<-EOF.split(/\s+/).each_slice(2).map {|k,v| [ k, v.to_f ] }]
A   71.03711
C   103.00919
D   115.02694
E   129.04259
F   147.06841
G   57.02146
H   137.05891
I   113.08406
K   128.09496
L   113.08406
M   131.04049
N   114.04293
P   97.05276
Q   128.05858
R   156.10111
S   87.03203
T   101.04768
V   99.06841
W   186.07931
Y   163.06333
  EOF

  def initialize(raw)
    super(raw.gsub(/\s+/, ''))
  end

  def motifs(motif)
    regex = motif_to_regex(motif)
    out = [ index(regex) ]
    until out.last.nil?
      out << index(regex, out.last + 1)
    end
    out.pop
    out.map {|i| i+1 }
  end

  def motif_to_regex(motif)
    Regexp.new(motif.gsub(/\{([^}])\}/, '[^\1]'))
  end

  def rna_count
    out = 1
    (chars + %w[ Stop ]).each do |char|
      out *= RNA::CODON_COUNT[char]
      out %= 1_000_000
    end
    out
  end

  def eql?(other)
    self == other
  end

  def monoisotopic_mass
    amino_acids.map {|aa| MONOISOTOPIC_MASS[aa] }.inject(:+)
  end

  def amino_acids
    chars
  end
end
