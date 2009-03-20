load 'slartibartfast/user.rb'

module Slartibartfast
  class Plugin
    def initialize(bot)
      @bot = bot
      @@private_commands ||= {} 
      @@private_commands[self.class.to_s] ||= []
    end
    
    def self.private_command(*commands)
      @@private_commands ||= {} 
      @@private_commands[self.class.to_s] ||= []
      commands.each do |command|
        @@private_commands[self.class.to_s] << command.to_s
        puts @@private_commands[self.class.to_s].join(",")
      end
    end
    
    def commands
      @@private_commands ||= {}
      @@private_commands[self.class.to_s] ||= [] 
      puts "DEBUG: Private methods: #{@@private_commands[self.class.to_s].join(", ")}"
      (self.methods - @@private_commands[self.class.to_s]) - Plugin.new(nil).methods
    end
    
    def private_commands
      @@private_commands ||= {} 
      @@private_commands[self.class.to_s] ||= []
      @@private_commands[self.class.to_s]
    end
    
    def reply(text)
      for line in text.split("\n")
        @bot.privmsg(@where, "#{@who}: #{line}")
      end
    end
    
    def call(who, where, what)
      @hostmask = who
      @who = @hostmask.split('!').first
      @where = where
      command, *args = what.split(/ /)
      begin
        __send__(command.to_sym, *args)
      rescue Exception => e
        puts "-!- Oops, got an error in the command #{command} (#{e.class.to_s}): #{e.message.to_s}"
        reply "Oops, got an error in the command #{command} (#{e.class.to_s}): #{e.message.to_s}"
      end
    end
    
    def method_missing(symb, *args)
      if symb.to_s[0,5] == "send_"
        args.last = ":"+args.last if args.last.split(/ /).length > 1
        @bot.send("#{symb.to_s.upcase[5..-1]} #{args.join(" ")}")
      else
        super
      end
    end
  end
end
