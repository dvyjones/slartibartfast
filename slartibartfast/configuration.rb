module Slartibartfast
  class Configuration
    
    def self.configuration
      @@configuration
    end
    
    def self.configure
      @@configuration = {}
      yield(self)
    end
    
    def self.server(host, port=6667)
      @@configuration[:servers] ||= []
      @@configuration[:servers] << [host, port]
    end
    
    def self.on_connect(raw)
      @@configuration[:on_connect] ||= []
      @@configuration[:on_connect] << raw
    end
    
    def self.method_missing(symbol, *args)
      @@configuration[symbol]=args.first
    end
    
    def self.load(pluginname)
      @@configuration[:autoload] ||= []
      @@configuration[:autoload] << pluginname
    end
  end
end
