require "open-uri"
module PatientsHelper
	def patientFindDepartment(timeslot)
    @doctor = Doctor.find(timeslot.doctor_id)
    @department = Department.find(@doctor.department_id)
    return @department.department_name
  end


  def patienFindDoctor(timeslot)
    @doctor = Doctor.find(timeslot.doctor_id)
    return @doctor.first_name+" "+@doctor.middle_name+" "+@doctor.last_name
  end

  def depFind(appointment)
  	@slot = Slot.find(appointment.slot_id)
  	@timeslot = Timeslot.find(@slot.timeslot_id)
  	@doctor = Doctor.find(@timeslot.doctor_id)
  	@department = Department.find(@doctor.department_id)
  	return @department.department_name
  end

  def dateFind(appointment)
  	@slot = Slot.find(appointment.slot_id)
  	return @slot.date.strftime('%m/%d/%Y')
  end

  def timeFind(appointment)
  	@slot = Slot.find(appointment.slot_id)
  	return @slot.time.strftime("%H:%M%p")
  end

  def docFind(appointment)
  	@slot = Slot.find(appointment.slot_id)
  	@timeslot = Timeslot.find(@slot.timeslot_id)
  	@doctor = Doctor.find(@timeslot.doctor_id)
  	return @doctor.first_name+" "+@doctor.middle_name+" "+@doctor.last_name
  end

	def findImagePatient(user)
		@photo = Photo.find(:first, :conditions => {:user_id => user})
		if @photo.nil?
			return "/images/contact.png"
		else
			return @photo.photo.url(:small)
		end
	end


	def findFile(url)
		@url = url.to_s
		@new_url = @url.split('?')
		return @new_url[0]

	end
end
