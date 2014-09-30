class EventsController < ApplicationController
  respond_to :html

  before_action :set_event, only: [:show, :edit, :update, :destroy,
    :accept_request, :reject_request]
  before_action :event_owner!, only: [:edit, :update, :destroy]

  def accept_request
    @attendance = Attendance.find_by id: params[:attendance_id] rescue nil
    @attendance.accept!
    "Applicant Accepted" if @attendance.save
    respond_with @attendance
  end

  def create
    @event = current_user.organized_events.new event_params

    respond_to do |format|
      if @event.save
        format.html {redirect_to @event, notice: "Event was successfully created."}
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit
  end

  def join
    @attendance = Attendance.join_event current_user.id, params[:event_id],
      "request_sent"
    "Request Sent" if @attendance.save
    respond_with @attendance
  end

  def index
    if params[:tag]
      @events = Event.tagged_with params[:tag]
    else
      @events = Event.all
    end
  end

  def my_events
    @events = current_user.organized_events
  end

  def new
    @event = Event.new
  end

  def reject_request
    @attendance = Attendance.find_by id: params[:attendance_id] rescue nil
    @attendance.reject!
    "Applicant Rejected" if @attendance.save
    respond_with @attendance
  end

  def show
    @event_owner = @event.organizer
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def event_owner!
    if @event.organizer_id != current_user.id
      redirect_to events_path
      flash[:notice] = "You do not have enough permissions to do this"
    end
  end

  def event_params
    params.require(:event).permit :title, :start_date, :end_date, :location,
      :agenda, :address, :organizer_id, :all_tags
  end

  def set_event
    @event = Event.friendly.find params[:id]
    @attendees = Event.show_accepted_attendees @event.id
    @pending_requests = Event.pending_requests @event.id
  end
end
