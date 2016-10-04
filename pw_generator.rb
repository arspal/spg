#!/usr/bin/env ruby
# Password generator
require 'optparse'
require 'clipboard'
require './pw_generator/generator.rb'

options = {}
OptionParser.new do |parser|
  parser.banner = 'Usage: pw_generator.rb [options]'

  parser.on('-l LENGTH', '--length LENGTH', Integer, 'Password length') do |l|
    options[:length] = l
  end

  parser.on('-w WORDS', '--words WORDS', Integer, 'Number of words in the password') do |w|
    options[:words] = w
  end

  parser.on('-h', '--help', 'Show this help message') do
    puts parser
    exit
  end

  parser.on('-v', '--verbose', 'interactive password generation') do
    require './pw_generator/verbose.rb'
    Verbose.new
  end

end.parse!


if options[:length] && options[:words]
  password = Pw.new
  password.generate(options[:length], options[:words])
  password.save
end
