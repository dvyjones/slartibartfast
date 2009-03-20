require 'base64'
load 'slartibartfast/plugin.rb'

class Base64Plugin < Slartibartfast::Plugin
  def base64(*str)
    reply Base64.encode64(str.join(' '))
  end
  
  def debase64(*str)
    reply Base64.decode64(str.join(' '))
  end
end
