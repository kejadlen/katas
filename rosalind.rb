require_relative 'dna'
require_relative 'misc'

if __FILE__ == $0
  require 'pry'
  require 'pry-byebug'
  binding.pry
  exit # For Pry
end
