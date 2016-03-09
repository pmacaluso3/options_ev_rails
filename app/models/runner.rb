require 'pry'

current_file = File.expand_path(__FILE__)

neighbors =  Dir[Dir.getwd + '/**'] - [current_file]

neighbors.each do |neighbor|
  require neighbor
end

binding.pry