require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "config/user.db"
)

class CreateNecessaryTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :hashed_password
    end
    
    create_table :privileges do |t|
      t.integer :user_id
      t.string :privilege
    end
  end
  
  def self.down
    drop_table :users
    drop_table :privileges
  end
end

CreateNecessaryTables.migrate(:up)
