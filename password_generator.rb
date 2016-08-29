require 'clipboard'
class PW
  def self.save(pw_ind)
    @@pw_ind = pw_ind
    File.open('passwords.txt', 'a+') { |file| file << "#{$pwArr[@@pw_ind]}\n" }
    Clipboard.copy($pwArr[@@pw_ind])
    puts "pw #{$pwArr[@@pw_ind]} saved & added to the clipboard"
    exit
  end
end
#Reading wordlist
eWords = File.readlines('words.txt')
eWordsLength = []
nums = [0,1,2,3,4,5,6,7,8,9]
eWords.each { |line| line.delete!("\n")
  tmp = line.length
  tmp = tmp - 1
  eWordsLength <<  tmp
}
eWordSize = eWords.size
uResp = ""
puts("Specify the Num. of: Characters/Words or [Q]uit")
print '> '
loop {
  #User input for a number of characters & words
  uResp = gets.chomp
  puts
  if uResp == 'q' || uResp == 'Q'
    exit
  end
  uResp = uResp.split('/')
  #initialization
  charSize = uResp[0].to_i
  wordLengthCap = uResp[0].to_i / uResp[1].to_i
  wordLengthCap.to_i
  password = ""
  #Checking password length
  if charSize < uResp[1].to_i
    puts "Can't do mutch with that, eh ?"
  elsif charSize < 3
    puts "Can't do mutch with that, eh ?"
  #---
  else
    if uResp.size > 2
      puts "Invalid number of parameters, try again"
      uResp = []
    else
      loop {
        $pwArr = []
        ind = 1
        1.upto(5)  {
          charSize = uResp[0].to_i
          password = ''
          ii = 1
          #Randoming words
          while ii <= uResp[1].to_i
            #if space available for new characters is less than our word length do this instead
            if charSize < wordLengthCap
              loop {
                i = rand(1..eWordSize)
                if eWords[i].length <= charSize
                  password << eWords[i].capitalize
                  charSize -=eWords[i].length
                  ii +=1
                  break
                end
              }
            #---
            else
              loop {
                i = rand(1..eWordSize)
                if eWords[i].length <= wordLengthCap
                  password << eWords[i].capitalize
                  charSize -=eWords[i].length
                  ii +=1
                  break
                end
              }
            end
          end
        1.upto(charSize) { password << nums.sample.to_s } #filling remaining space with numbers
        puts "#{ind}. #{password}" #stdout the result
        $pwArr.push(password)
        ind +=1
      }
        puts
        puts "[G]enerate a new bunch/[S]ave password/[Q]uit"
        print '> '
        loop {
          uResp2 = gets.chomp
          puts
          if uResp2 == 'g' || uResp2 == 'G'
            break
          elsif uResp2 == 'q' || uResp2 == 'Q'
            exit
          elsif uResp2 == 's' || uResp2 == 'S'
            puts 'Wich one do you like: '
            print '> '
            loop {
              uResp2 = gets.chomp
              case uResp2
              when '1'; PW.save(0)
              when '2'; PW.save(1)
              when '3'; PW.save(2)
              when '4'; PW.save(3)
              when '5'; PW.save(4)
              when uResp2 == "q" || uResp2 == "Q"
                exit
              end
              puts 'Unrecognizable command'
              print '> '
            }
          end
          puts 'Unrecognizable command'
          print '> '
        }
      }
    end
  end
}
