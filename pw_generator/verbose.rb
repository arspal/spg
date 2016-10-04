#verbose

#Reading wordlist
class Verbose

  def initialize
    puts('Specify the number of ' + yellow_bold('Characters') + '/' + yellow_bold('Words ') + 'or ' + underline('Q') + 'uit')
    print '> '
    @first_run = true
    @password = Pw.new
    get_userinput
  end

  def get_userinput
    user_input = gets.chomp
    if @first_run == true
      exit if user_input == 'q' || user_input == 'Q'
      user_input = user_input.split(/[,\/:\s_]/)
      check_input(user_input, 1)
      @first_run = false
      generate_password_list
    else
      if user_input.to_i > 0
        case user_input
        when '1'; @password.save(0)
        when '2'; @password.save(1)
        when '3'; @password.save(2)
        when '4'; @password.save(3)
        when '5'; @password.save(4)
        end
        # puts 'Unrecognizable command'
        # print '> '
      else
        check_input(user_input, 2)
      end
    end
  end


  private

  def colorize(text,code); "\e[#{code}m#{text}\e[0m" end
  def underline(text); colorize(text,4) end
  def yellow_bold(text); colorize(text,33) end


  def check_input(user_input, stage)
    case stage
    when 1
      if user_input.size != 2
        response('invalid')
        get_userinput
      else
        # Check for an natur. number
        if (user_input[0] && user_input[1]).to_i > 0
          @password_length = user_input[0].to_i
          @number_of_words = user_input[1].to_i
        else
          response('need_a_natural_num')
          get_userinput
        end

        if @password_length <= 3
          response('too_short')
          get_userinput
        elsif (@password_length < @number_of_words)
          response('words > char')
          get_userinput
        end
      end
    when 2
      case user_input
      when 'q'
        exit
      when 'Q'
        exit
      when 'g'
        generate_password_list
      when 'G'
        generate_password_list
      when 's'
        save_pw
      when 'S'
        save_pw
      end
    end
  end

  def response(resp)
    case resp
    when 'invalid'
      puts 'Invalid number of parameters, try again'
      print '> '
    when 'too_short'
      puts 'Password is too short'
      print '> '
    when 'words > char'
      puts 'You can\'t have more words than characters'
      print '> '
    when 'need_a_natural_num'
      puts 'Need a natural number for this to work'
      print '> '
    end
  end

  def generate_password_list
    $pwArr = []
    # Display a list of generated passwords
    puts
    0.upto(4) do |i|
      @password.generate(@password_length, @number_of_words)
      $pwArr.push(@password.pwd)
      puts "#{i+1}. #{$pwArr[i]}"
    end
    puts
    puts(underline('G') + 'enerate more/' + underline('S') + 'ave password or ' + underline('Q') + 'uit)')
    print '> '
    get_userinput
  end

  def save_pw
    puts 'Which one do you like'
    print '> '
    get_userinput
  end

end
