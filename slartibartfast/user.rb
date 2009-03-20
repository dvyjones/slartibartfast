require 'digest/sha1'
require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "config/user.db"
)

module Slartibartfast
  class UserCredentialsError < Exception ; end
  class UserExistsError < Exception ; end
  
  class User < ActiveRecord::Base
    has_many :privileges
  
    def password=(pass)
      self.hashed_password = Digest::SHA1.hexdigest(pass)
    end
  end
  
  class Privilege < ActiveRecord::Base
    belongs_to :user
  end
  
#  class User
#    def self.setup(bot)
#      @@bot = bot
#      @@users = {}
#    end
#    
#    def self.handleline(line)
#      if /:([\S]+)\sPRIVMSG\s#{@@bot.config[:nick]}\s:(register|identify|logout)(?: (.*))?/i =~ line
#        from, command, what = $1, $2, $3, $4
#        where = from.split("!").first
#        what ||= ""
#        case command.downcase
#          when 'register'
#            begin
#              self.register(where, *(what.split(' ', 2)))
#            rescue UserExistsError
#              @@bot.send("PRIVMSG #{where} :I'm sorry, that user already exists!")
#            rescue ArgumentError, NoMethodError
#              @@bot.send("PRIVMSG #{where} :Usage: /msg #{@@bot.config[:nick]} register <username> <password>")
#            end
#          when 'identify'
#            begin
#              self.identify(where, from, *(what.split(' ', 2)))
#            rescue UserCredentialsError
#              @@bot.send("PRIVMSG #{where} :I'm sorry, but you entered the wrong username or password!")
#            rescue ArgumentError, NoMethodError
#              @@bot.send("PRIVMSG #{where} :Usage: /msg #{@@bot.config[:nick]} identify <username> <password>")
#            end
#          when 'logout'
#            self.logout(hostmask)
#        end
#      end
#    end
#    
#    def self.logout(hostmask)
#      @@users.delete(hostmask)
#    end
#    
#    def self.register(where, username, password)
#      @@db ||= SQLite3::Database.new('config/user.db')
#      if @@db.get_first_value("SELECT COUNT(*) FROM users WHERE username=?", username).to_i > 0
#        raise UserExistsError
#      else
#        @@db.execute("INSERT INTO users (username, password) VALUES (?, ?)", username, Digest::SHA1.hexdigest(password))
#        @@bot.send("PRIVMSG #{where} :You're now registered as #{username} and may now identify.")
#      end
#    end
#    
#    def self.identify(where, hostmask, username, password)
#      @@db ||= SQLite3::Database.new('config/user.db')
#      if @@db.get_first_value("SELECT password FROM users WHERE username=?", username) == Digest::SHA1.hexdigest(password)
#        res = @@db.execute("SELECT permission, negate FROM permissions WHERE username=?", username)
#        perms = []
#        perms_negate = []
#        res.each do |perm, negate|
#          negate ? perms_negate << perm : perms << perm
#        end
#        @@users[hostmask] = { :username => username, :permissions => (perms - perms_negate) }
#        @@bot.send("PRIVMSG #{where} :You're now logged in as #{username}.")
#      else
#        raise UserCredentialsError
#      end
#    end
#    
#    def self.retrieve(hostmask)
#      @@users[hostmask] ? new(@@users[hostmask]) : nil
#    end

#    def self.retrieveuser(username)
#      @@db ||= SQLite3::Database.new('config/user.db')
#      if @@db.get_first_value("SELECT COUNT(*) FROM users WHERE username=?", username).to_i > 0
#        res = @@db.execute("SELECT permission, negate FROM permissions WHERE username=?", username)
#        perms = []
#        perms_negate = []
#        res.each do |perm, negate|
#          negate ? perms_negate << perm : perms << perm
#        end
#        return { :username => username, :permissions => (perms - perms_negate) }
#      else
#        raise UserExistsError
#      end
#    end
#    
#    def initialize(info)
#      @info = info
#    end
#    
#    def reload_perms
#      res = @@db.execute("SELECT permission FROM permissions WHERE username=?", @info[:username])
#      perms = []
#      res.each do |perm|
#        perms << perm
#      end
#      @info[:permissions] = (perms)
#    end
#    
#    def allowed?(perm)
#      reload_perms
#      @info[:permissions].include?(perm.to_s.gsub(/\s/, '')) || @info[:permissions].include?('admin')
#    end
#    
#    def allow(perm)
#      @@db ||= SQLite3::Database.new('config/user.db')
#      @@db.execute("INSERT INTO permissions (username, permission) VALUES (?, ?, false)", @info[:username], perm.gsub(/\s/, ''))
#    end
#    
#    def disallow(perm)
#      @@db ||= SQLite3::Database.new('config/user.db')
#      @@db.execute("DELETE FROM permissions WHERE username=?", @info[:username])
#    end
#  end
end
