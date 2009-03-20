require 'digest/sha1'
require 'digest/md5'

load 'slartibartfast/plugin.rb'

class DigestPlugin < Slartibartfast::Plugin
  def md5(*str)
    reply Digest::MD5.hexdigest(str.join(' '))
  end
  
  def sha1(*str)
    reply Digest::SHA1.hexdigest(str.join(' '))
  end
  
  def sha256(*str)
    reply Digest::SHA2.new(256).update(str.join(' ')).hexdigest
  end
  
  def sha384(*str)
    reply Digest::SHA2.new(384).update(str.join(' ')).hexdigest
  end
  
  def sha512(*str)
    reply Digest::SHA2.new(512).update(str.join(' ')).hexdigest
  end
end
