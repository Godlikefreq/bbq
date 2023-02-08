class EventMailer < ApplicationMailer

  def subscription(subscription, email)
    @email = email
    @name = subscription.user_name
    @event = subscription.event

    mail to: email, subject: "Новая подписка на #{@event.title}"
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: "Новый комментарий @ #{@event.title}"
  end

  def photo(photo, email)
    @photo = photo
    @event = photo.event

    mail to: email, subject: "Новая фотография в #{@event.title}"
  end
end
