module AdmittedRecordHelper
  def findPatient(msg)
    @patient = Patient.find(msg)
    return @patient.first_name+" "+@patient.middle_name+" "+@patient.last_name
  end
end
