class Patient < ActiveRecord::Base
  #validates_presence_of :email, :message => "hello"
  has_many :users, :as => :user_record

end
