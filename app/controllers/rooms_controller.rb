require 'csv'
class RoomsController < ApplicationController
  

  before_filter :first_rule,
    :only => [:edit, :destroy, :updateRoom]

  def first_rule
    @bed = Bed.find(params[:id])
  end


  def index
    @rooms = Room.all
      respond_to do |format|
        format.html
        format.csv {send_data Room.to_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=Bed_availability_in_rooms.csv"}
      end
  end

  def reports
    redirect_to :controller => :rooms
  end

  def new
    @room = Room.new
    @departments = Department.all
  end

  def edit
    @room_beds = Bed.count(:id, :conditions => {:room_id => params[:id]})
    @department = Department.find(@room.department_id)
  end

  def create
    @room = Room.create(:no_of_beds => params[:no_of_beds], :department_id => params[:category][:id])
    @no = params[:no_of_beds].to_i
    @no.times do
      @room.beds.create()
    end
    redirect_to :controller => :rooms
  end


  def updateRoom
    @room.update_attributes(:no_of_beds => @room.no_of_beds.to_i+params[:no_of_beds].to_i)
    @no = params[:no_of_beds].to_i
    @no.times do
      @room.beds.create()
    end
    redirect_to :controller => :rooms
  end


  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml  { head :ok }
    end
  end

  def showRooms
    @rooms = Room.find(:all, :conditions => {:department_id => params[:id]})
    render :action => "index"

  end
end
