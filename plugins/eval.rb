require 'stringio'

load 'slartibartfast/plugin.rb'

class EvalPlugin < Slartibartfast::Plugin
  def eval(*stuff)
    if @who == @bot.config[:owner]
      ret = Kernel.eval(stuff.join(" "))
      reply ret
    end
  end
end
