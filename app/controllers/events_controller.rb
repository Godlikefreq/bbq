class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[ show index ]
  before_action :set_event, only: %i[ show ]
  before_action :password_guard!, only: %i[ show ]

  after_action :verify_authorized, except: %i[ show index ]

  def index
    @events = policy_scope(Event)
  end

  def show
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build
    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)
    authorize @event

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: t("controllers.events.created") }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: t("controllers.events.updated") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @event

    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url, notice: t("controllers.events.destroyed") }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def password_guard!
    return true if @event.pincode.blank?
    return true if signed_in? && current_user == @event.user

    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    unless @event.pincode_valid?(cookies.permanent["events_#{@event.id}_pincode"])
      flash.now[:alert] = t("controllers.events.wrong_pincode") if params[:pincode].present?
      render "password_form"
    end
  end
end
