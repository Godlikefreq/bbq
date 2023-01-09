class CommentsController < ApplicationController
  before_action :set_event, only: %i[ create destroy ]
  before_action :set_comment, only: %i[ destroy ]

  def create
    @new_comment = @event.comments.build(comment_params)
    @new_comment.user = current_user

    respond_to do |format|
      if @new_comment.save
        notify_subscribers(@event, @new_comment)
        format.html { redirect_to @event, notice: t("controllers.comments.created") }
      else
        format.html { render "events/show", status: :unprocessable_entity }
      end
    end
  end

  def destroy
    message = {notice: t("controllers.comments.destroyed")}

    if current_user_can_edit?(@comment)
      @comment.destroy!
    else
      message = {status: :unprocessable_entity}
    end

    redirect_to @event, message
  end

  private
  def set_event
    @event = Event.find(params[:event_id])
  end

  def set_comment
    @comment = @event.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :user_name)
  end

  def notify_subscribers(event, comment)
    all_emails = (event.subscriptions.map(&:user_email) + [event.user.email] - [comment.user.email]).uniq

    all_emails.each do |mail|
      EventMailer.comment(event, comment, mail).deliver_now
    end
  end
end