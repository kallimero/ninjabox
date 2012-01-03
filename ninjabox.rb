#!/usr/bin/ruby

require 'readline'
require "open-uri"

trap('INT', 'SIG_IGN') # trololo (:

@tab = []

def list(type)     
	if File.exists?(type) && File.directory?(type)
		puts "==> listing #{type} scripts..."
		Dir.glob(type+"/*").each do |file|
			if file != "./ninjabox.rb"
				puts "  ->" + @tab.index("./"+file).to_s + " = " + file.to_s
			end
		end
		
	else
		puts "==> #{type} don't exist. Check your args." 
	end
end


def maj()


end

def version()
	puts "\n   -------------------------" 
	puts "   |    NinjA B0x v0.1     |"
	puts "   -------------------------"
	puts "\n    No copyright. Be happy.
		         Coded by some ducks.\n\n"

end

def help()

	puts "Real ninjas don't need any help."

end

def loadscripts()

	print "   Loading scripts."
	i = 0
	@tab = []
	Dir.glob("./*").each do |file|
		Dir.glob(file+"/*").each do |file|
			@tab[i] = file
			i += 1
			print "."
		end
	end
	print "\n"			
end

	puts "\n   ----------------------------"
	puts "   .:: Welcome on ninja Box ::."
	puts "   ----------------------------"
	
	loadscripts()
	
	puts "\n\n-- type help if your are loose.\n\n"
	
	
	continue = true

	while continue
	
	commandes = [
	'open', 'version',
	'help', 'quit',
	'set', 'print', 'sh',
	'list', 'reload', 'clear'
	].sort

	comp = proc { |s| commandes.grep( /^#{Regexp.escape(s)}/ ) }

	Readline.completion_append_character = " "
	Readline.completion_proc = comp

	
	command = Readline.readline('>> ')
	Readline::HISTORY.push(command)
	
		case command
		
			
		
			when /^help ?$/, /^h$/
				help()
				
			when /^clear ?$/, /^cls ?$/
				system("clear")
			
			when /^quit ?$/, /^q$/
				puts "Bye my ninja..."
				continue = false
			
			when /^list ([a-z]+)$/i, /^l ([a-z]+)$/i
				list $1
			
			when /^list ?$/, /^l$/
				list(".")
			
			when /^version ?$/, /^v$/
				version()
			
			when /^reload ?$/
				loadscripts()
				
			when /^sh (.+)$/
				system($1)
			
			when /^set \$([a-zA-Z0-9_]+) ?= ?(.+)$/, /^s \$([a-zA-Z0-9_]+) ?= ?(.+)$/
				ENV[$1] = $2
				puts "$"+$1+" = "+$2
			
			when /^print \$([a-zA-Z0-9_]+)$/, /^p \$([a-zA-Z0-9_]+)$/
				if ENV[$1].nil? 
					puts "Unknown variable."
				else puts "$" + $1 + " = " + ENV[$1] end
			
			when /^open ([0-9]+)$/
				puts "Executing #{@tab[$1.to_i]} ..."
				system(@tab[$1.to_i])
				
			
			when /(.+)/
				puts "Unknown command. Please see the help and stop drink."
		end

	end



