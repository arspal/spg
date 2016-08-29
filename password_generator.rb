require 'clipboard'
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
while true do
	#User input for a number of characters & words
	uResp = gets().chomp
	puts
	if uResp == "q"
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
			while true do
				pwArr = []
				ind = 1
				1.upto(5) { charSize = uResp[0].to_i
					password = ''
					ii = 1
				#Randoming words
					while ii <= uResp[1].to_i do
						#if space available for new characters is less than our word length do this instead
						if charSize < wordLengthCap
							while true do
								i = rand(1..eWordSize)
								if eWords[i].length <= charSize
									password << eWords[i].capitalize
									charSize -=eWords[i].length
									ii +=1
									break
								end
							end
						#---
						else
							while true do
								i = rand(1..eWordSize)
								if eWords[i].length <= wordLengthCap
									password << eWords[i].capitalize
									charSize -=eWords[i].length
									ii +=1
									break
								end
							end
						end
					end
					#filling remaining space with numbers
					1.upto(charSize) {
						password << nums.sample.to_s
					}
					#stdout the result
					puts "#{ind}. #{password}"
					pwArr.push(password)
					ind +=1
				}
				puts
				puts "[G]enerate a new bunch/[S]ave password/[Q]uit"
				print '> '
				while true do
					uResp2 = gets().chomp
					puts
					if uResp2 == "G" || uResp2 == "g"
						break
					elsif uResp2 == "Q" || uResp2 == "q"
						exit
					elsif uResp2 == "S" || uResp2 == "s"
						puts 'Wich one do you like: '
						print '> '
						while true do
							uResp2 = gets().chomp
							case uResp2
							when '1'
								File.open('passwords.txt', 'a+') { |file| file << "#{pwArr[0]}\n" }
								Clipboard.copy(pwArr[0])
								puts "pw #{pwArr[0]} saved & added to the clipboard"
								exit
							when '2'
								File.open('passwords.txt', 'a+') { |file| file << "#{pwArr[1]}\n" }
								Clipboard.copy(pwArr[1])
								puts "pw #{pwArr[1]} saved & added to the clipboard"
								exit
							when '3'
								File.open('passwords.txt', 'a+') { |file| file << "#{pwArr[2]}\n" }
								Clipboard.copy(pwArr[2])
								puts "pw #{pwArr[2]} saved & added to the clipboard"
								exit
							when '4'
								File.open('passwords.txt', 'a+') { |file| file << "#{pwArr[3]}\n" }
								Clipboard.copy(pwArr[3])
								puts "pw #{pwArr[3]} saved & added to the clipboard"
								exit
							when '5'
								File.open('passwords.txt', 'a+') { |file| file << "#{pwArr[4]}\n" }
								Clipboard.copy(pwArr[4])
								puts "pw #{pwArr[4]} saved & added to the clipboard"
								exit
							when uResp2 == "Q" || uResp2 == "q"
								exit
							end
							puts 'Unrecognizable command'
							print '> '
						end
					end
					puts 'Unrecognizable command'
					print '> '
				end
			end
		end
	end
end

