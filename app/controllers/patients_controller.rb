class PatientsController < ApplicationController

  def index
      @patients = Patient.all
  end

  def new


  end

  def details_view_admin
    @p = User.find(:first, :conditions => {:user_record_id => params[:id]})
    @patient = @p.user_record
  end

  def details_view_patient
    @p = User.find(session[:current_user_id])
    @patients = @p.user_record
    @appointments = Appointment.find(:all, :conditions => {:patient_id => @patients.id})
  end

  def details_view_doctor
    @flag = 0
    @p = User.find(:first, :conditions => {:user_name => params[:user_id]})
    @patient = @p.user_record
    @appointment = Appointment.find(:first, :conditions => {:patient_id => @patient.id})
    @slot = Slot.find(@appointment.slot_id)
    if @slot.date.strftime("%m:%d:%y") < Time.now.strftime("%m:%d:%y")
      @flag = 1
    elsif @slot.date.strftime("%m:%d:%y") == Time.now.strftime("%m:%d:%y") && @slot.time.strftime("%H:%M") > Time.now.strftime("%H:%M")
      @flag = 1
    else
      @flag = 0
    end
  end

  def patient_profile_form
    @user = User.find(session[:current_user_id])
    @patient = @user.user_record

  end

  def updateprofile
    @blood_group = Bloodgroup.find(params[:blood][:id])
    @gender = Gender.find(params[:gender][:id])
    @date = Date.civil(*params[:event].sort.map(&:last).map(&:to_i))
    @patient = Patient.find(params[:patient])
    @patient.update_attributes(:contact_number => params[:contact_number], :photo => params[:photo],
  :date_of_birth => @date, :blood_group => @blood_group.name, :gender => @gender.name,
:address => params[:address])
    @user = User.find(:first, :conditions => {:user_record_id  => params[:patient]})
    @user.update_attributes(:profile_status => 1)
    redirect_to ("/patients/details_view_patient")
  end

  def searchslots
    @doctors = Doctor.find(:all, :conditions => {:department_id => params[:department][:id]})
    @timeslots = Timeslot.find(:all, :conditions => {:date => Date.civil(*params[:event].sort.map(&:last).map(&:to_i)), :doctor_id => @doctors.each do |d| d.id end })
    @flag = 0
    @timeslots.each do |t|
      @slot = t.slots
      @slot.each do |s|
        if s.status == 0
          @flag = 1
        end
      end
    end
  end

  def delete
    @user = User.find(:first, :conditions => {:user_record_id => params[:id]})
    @user.destroy
    redirect_to :controller => :patients
  end
end
