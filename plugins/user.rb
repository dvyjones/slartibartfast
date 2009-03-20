load 'slartibartfast/plugin.rb'
load 'slartibartfast/user.rb'

class UserPlugin < Slartibartfast::Plugin
  private_command :register, :identify

  def allow(user, perm)
#    if Slartibartfast::User.retrieve(@hostmask).allowed? :allow
#      Slartibartfast::User.retrieveuser(user).allow(perm) 
#    else
#      reply "You aren't allowed to do that!"
#    end
    reply "Not implemented at the moment"
  end
  
  def disallow(user, perm)
#    if Slartibartfast::User.retrieve(@hostmask).allowed? :allow
#      Slartibartfast::User.retrieveuser(user).disallow(perm) 
#    else
#      reply "You aren't allowed to do that!"
#    end
    reply "Not implemented at the moment"
  end
  
  def register(username, *password)
    reply "Hmm"
  end
  
  def identify(username, *password)
    reply "Hmm"
  end
end
