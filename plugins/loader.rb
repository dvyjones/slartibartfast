load 'slartibartfast/plugin.rb'

class LoaderPlugin < Slartibartfast::Plugin
  def reload(plugin)
    if @who.downcase == "dvyjones"
      @bot.load(plugin)
      reply "Loaded #{plugin}"
    end  
  end
end
