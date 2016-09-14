#!/usr/bin/env ruby
# user prompt
require './pw_generator.rb'

module Prompt
  def self.response(resp_num)
    case resp_num
    when 1
      puts 'Can\'t do mutch with that, eh ?'
    when 2
      puts 'Unrecognizable command'
      print '> '
    end
  end
end

user_input = ''
puts 'Specify the Num. of: Characters/Words or [Q]uit'
print '> '
loop do
  user_input = gets.chomp
  puts
  if user_input == ('q' || 'Q')
    exit
  end
  user_input = user_input.split('/')

  # initialization
  password_length = user_input[0].to_i
  number_of_words = user_input[1].to_i
  password = Pw.new

  # Checking password length
  if password_length < number_of_words
    Prompt.response(1)
  elsif password_length < 3
    Prompt.response(1)
  else
    if user_input.size > 2
      puts "Invalid number of parameters, try again"
      user_input = []
    else
      loop do
        $pwArr = []
        ind = 0
        # Display a list of generated passwords
        1.upto(5) do
          password.generate(password_length, number_of_words)
          $pwArr.push(password.pwd)
          puts "#{ind+1}. #{$pwArr[ind]}"
          ind +=1
        end

        puts
        puts "[G]enerate a new bunch/[S]ave password/[Q]uit"
        print '> '
        loop do
          user_input = gets.chomp
          puts
          if user_input == ('g' || 'G')
            break
          elsif user_input == ('q' || 'Q')
            exit
          elsif user_input == ('s' || 'S')
            puts 'Which one do you like: '
            print '> '
            loop do
              user_input = gets.chomp
              case user_input
              when '1'; password.save(0)
              when '2'; password.save(1)
              when '3'; password.save(2)
              when '4'; password.save(3)
              when '5'; password.save(4)
              when user_input == 'q'
                exit
              end
              Prompt.response(2)
            end
          end
          Prompt.response(2)
        end
      end
    end
  end
end
