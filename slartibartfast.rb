require 'socket'

require 'slartibartfast/configuration'
require 'config/config'

module Slartibartfast
  class Bot
    def initialize
      @config = Configuration.configuration
      @plugins = {}
      @commands = {}
      autoload()
    end
    
    def autoload
      for plugin in @config[:autoload]
        load(plugin)
      end
    end
    
    def load(plugin)
      Kernel.load("plugins/#{plugin.to_s}.rb")
      #camelcased = join('', map{ ucfirst $_ } split(/(?<=[A-Za-z])_(?=[A-Za-z])|\b/, $s));
      camelcased = plugin.to_s.split(/(?=[A-Za-z])_(?=[A-Za-z])|\b/).map(&:capitalize).join('')
      #camelcased = plugin.to_s.split('_').map{|m|m = m.capitalize[1..-1]}.join('')
      @plugins[plugin.to_sym] = Object.const_get("#{camelcased}Plugin").new(self)
      puts "-!- Loaded the plugin #{camelcased}Plugin"
      for command in @plugins[plugin.to_sym].commands
        @commands[command] = @plugins[plugin.to_sym]
        puts "-!- Loaded the command #{command} and bound to plugin #{camelcased}Plugin"
      end
    end
    
    def connect
      @socket = TCPSocket.new(*(@config[:servers].first))
      puts "-!- Connecting to #{@config[:servers].first.join(":")} as #{@config[:nick]}"
      send("USER #{@config[:username]} ! ! :#{@config[:realname]}")
      send("NICK #{@config[:nick]}")
      
      until @socket.closed?
        lines = @socket.gets
        for line in lines.split("\n")
          if line
            line.chomp!
            puts " << #{line}"
            if line =~ /^PING (.*)/
              send("PONG #{$1}")
            else
              handle(line)
            end
          end
        end
      end
    end
    
    def handle(line)
      if /:([\S]+)\sPRIVMSG\s(\S+)\s:(?:#{@config[:nick]}:\s|#{@config[:prefix]})(.*)/ =~ line.chomp
        caller, channel, message = [$1, $2, $3]
        if @commands.has_key?(message.split(/ /).first)
          @commands[message.split(/ /).first].call(caller, channel, message)
        end
      elsif line =~ /^:.*? 422/
        @config[:on_connect].each do |c|
          send(c)
        end
      end
    end
    
    def send(msg)
      @socket.puts(msg)
      puts " >> #{msg}"
    end
    
    def privmsg(where, what)
      send("PRIVMSG #{where} :#{what}")
    end
    
  end
end

bot = Slartibartfast::Bot.new
bot.connect
