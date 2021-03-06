require 'securerandom'
class UsersController < ApplicationController



  filter_access_to :all
  # list all the users
  def index
    @users = User.all
  end

  # patient registration form
  def patient_registration_form
    @patient = Patient.new
  end

  # admin registration form
  def admin_registration_form
    @admin = User.new
  end

  # doctor registration form
  def doctor_registration_form
    @doctor = Doctor.new
    @departments = Department.all
  end


  # signup method
  def signup
    if params[:id] == "3" # patinet
      @patient = Patient.new(params[:patient])
      unless @patient.save
        render :action => "patient_registration_form"
      else
        redirect_to("/")
       end
    elsif params[:id] == "2" # doctor
      @doctor = Doctor.new(params[:doctor])
      unless @doctor.save
        render :action => "doctor_registration_form"
      else
        redirect_to("/doctors/index")
      end
    elsif params[:id] == "1" # admin
      @admin = User.new(params[:admin])
      unless @admin.save
        render :action => "admin_registration_form"
      else
        redirect_to("/sessions/show")
      end
    end
  end
end
