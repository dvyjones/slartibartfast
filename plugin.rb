class Plugin
  def initialize(bot)
    @bot = bot 
  end
  
  def commands
    self.methods - Plugin.new(nil).methods 
  end
  
  def reply(text)
    @bot.privmsg(@where, "#{@who}: #{text}")
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
