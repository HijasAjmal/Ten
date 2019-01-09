require 'securerandom'
class SessionsController < ApplicationController

  def index
    if session[:current_user_id]
      redirect_to :controller => :sessions, :action => "signin"
    end
  end

  def create
    # ...
    session[:current_user_id] = @user.id
    # ...
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to :controller => :sessions, :action => "index"
  end

  def signin
    if session[:current_user_id]
      @user = User.find(session[:current_user_id])
    else
      @user = User.find(:first, :conditions => { :user_name => params[:user_name] , :password => params[:password]})
    end

    if @user.nil?
      flash[:notice] = 'User Name or Password incorrect.....!'
      redirect_to :controller => :sessions
    elsif @user.confirmed == 0
      flash[:notice] = 'Please check your email and confirm you account.....!'
      redirect_to ("/")
    elsif @user.confirmed == 1 && @user.profile_status == 1
      session[:current_user_id] = @user.id
      if @user.user_record_type == "Admin"
        redirect_to("/sessions/dashboard")
      elsif @user.user_record_type == "Doctor"
        redirect_to("/doctors/patient_details_login")
      elsif @user.user_record_type == "Patient"
        redirect_to :controller => :patients, :action => :details_view_patient
      end
    elsif @user.profile_status != 1 && @user.user_record_type == "Doctor"
      session[:current_user_id] = @user.id
      redirect_to("/doctors/doctor_profile_form")
    elsif @user.profile_status != 1 && @user.user_record_type == "Patient"
      session[:current_user_id] = @user.id
      redirect_to("/patients/patient_profile_form")
    else
      flash[:notice] = 'Please check your email...!'
      redirect_to :controller => :sessions
    end
  end
  def show
    @admin = User.find(:all, :conditions =>{:user_record_type => "Admin"})
  end

  def confirm
    @user = User.find(:first, :conditions => { :confirmation_token => params[:id]})
    if @user.nil?
      flash[:notice] = 'This link is not valid..!'
      signin()
    else
      @user.update_attributes(:confirmation_token => nil, :confirmed => 1)
      session[:current_user_id] = @user.id

      signin()
    end
  end

  def forget
    @user = User.find(:first, :conditions => { :email => params[:email]})
    if @user.nil?
      flash[:notice] = 'This email is not exist in our database..!'
      redirect_to("/")
    else
      @user.update_attributes(:remember_token => SecureRandom.hex)
      UserMailer.deliver_password_email(@user)
      flash[:notice] = 'Password reset link is in your email..!'
      redirect_to("/")
    end
  end

  def changepwd
    @user = User.find(:first, :conditions => { :remember_token => params[:id]})
    if @user.nil?
      flash[:notice] = 'This link is not valid..!'
      redirect_to("/")
    else
      @user.update_attributes(:password => params[:password], :remember_token => nil)
      flash[:notice] = 'successfully updated your account password..!'
      redirect_to("/")
    end
  end
end