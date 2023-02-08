class EventNotificationJob < ApplicationJob
  queue_as :default

  def perform(object)
    all_emails = (object.event.subscriptions.map(&:user_email) + [object.event.user.email] - [object.user&.email]).uniq

    all_emails.each do |mail|
      case object
      when Subscription
        EventMailer.subscription(object, mail).deliver_later
      when Photo
        EventMailer.photo(object, mail).deliver_later
      when Comment
        EventMailer.comment(object, mail).deliver_later
      end
    end
  end
end
