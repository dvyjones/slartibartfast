load 'slartibartfast/plugin.rb'

class BasicPlugin < Slartibartfast::Plugin
  def join(channel)
    @bot.send("JOIN #{channel}") if @who == @bot.config[:owner]
  end
  
  def part(channel, *message)
    if channel[0,1] == "#"
      send_part(channel, message.join(" ")) if @who == @bot.config[:owner]
    else
      send_part(channel, message.join(" ")) if @who == @bot.config[:owner]
    end
  end
  
  def raw(*rawstuff)
    @bot.send(rawstuff.join(" ")) if @who == @bot.config[:owner]
  end
end
