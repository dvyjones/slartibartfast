load 'plugin.rb'

class BasicPlugin < Plugin
  def join(channel)
    @bot.send("JOIN #{channel}") if @who == "Dvyjones"
  end
  
  def part(channel)
    send_part(channel) if @who == "Dvyjones"
  end
  
  def raw(*rawstuff)
    @bot.send(rawstuff.join(" ")) if @who == "Dvyjones"
  end
end
