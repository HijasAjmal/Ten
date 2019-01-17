class User < ActiveRecord::Base
  belongs_to :user_record, :polymorphic => true, :dependent => :destroy
  has_many :photos
  has_many :reports
  after_create :set_admin_credential

  def role_symbols
    return self.user_record_type.underscore.to_sym.to_a
  end


  def self.update_user_credential(record)
    @user = User.new()
    @user.user_record = record
    @user_type = @user.user_record
    @user.update_attributes(:first_name => @user_type.first_name,
      :middle_name => @user_type.middle_name, :last_name => @user_type.last_name,
      :email => @user_type.email, :user_name => @user_type.first_name+"@U"+@user.id.to_s,
      :password => @user_type.first_name+"@U"+@user_type.id.to_s,
      :confirmation_token => SecureRandom.hex(10) )
    UserMailer.deliver_welcome_email(@user_type, @user)
  end

  def set_admin_credential
    self.update_attributes(:user_name => "A00"+self.id.to_s, :password => self.first_name+"@A"+self.id.to_s, :user_record_type => "Admin", :confirmed => 1, :profile_status => 1)
    UserMailer.deliver_admin_email(self)
  end
end
