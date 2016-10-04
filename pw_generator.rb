#!/usr/bin/env ruby
# Password generator
require 'optparse'
require 'clipboard'

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

end.parse!

class Pw
  attr_accessor :pwd
  def initialize
    @word_list = File.readlines('word_list.txt').each { |line| line.delete!("\n") }
  end

  def generate(pw_length, number_of_words)
    max_word_length = pw_length / number_of_words
    @curr_password_length = pw_length
    @pwd = ''
    @index = 1

    while @index <= number_of_words do
      # if space available for new characters is less than our word length do this
      calculate(@curr_password_length) if @curr_password_length < max_word_length
      calculate(max_word_length)
    end
    # filling remaining space with numbers
    1.upto(@curr_password_length) { @pwd << rand(0..9).to_s }
  end

  def save(*pw_id)
    if pw_id[0] != nil
      write_to_file($pwArr[pw_id[0]])
      Clipboard.copy($pwArr[pw_id[0]])
      puts "pw: #{$pwArr[pw_id[0]]} saved & coppied"
      exit
    else
      write_to_file(@pwd)
      Clipboard.copy(@pwd)
      puts "pw: #{@pwd}"
    end
  end

  private

  def calculate(curr_pw_length)
    loop do
      i = rand(1..@word_list.size)
      if @word_list[i].length <= curr_pw_length
        @pwd << @word_list[i].capitalize
        @curr_password_length -=@word_list[i].length
        @index +=1
        break
      end
    end
  end

  def write_to_file(string)
    File.open('passwords.txt', 'a+') { |file| file << "#{string}\n" }
  end

end

if (options[:length] && options[:words]) != nil
  password = Pw.new
  password.generate(options[:length], options[:words])
  password.save
end
