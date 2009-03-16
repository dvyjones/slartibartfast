require 'plugin'

class LoaderPlugin < Plugin
  def reload(plugin)
    if @who.downcase == "dvyjones"
      @bot.load(plugin)
      reply "Loaded #{plugin}"
    end  
  end
end
