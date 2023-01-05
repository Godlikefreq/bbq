class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true

  with_options if: -> { user.present? } do
    validate :self_subscription
    validates :user, uniqueness: { scope: :event_id }
  end

  with_options unless: -> { user.present? } do
    validate :email_presence
    validates :user_name, presence: true
    validates :user_email, uniqueness: { scope: :event_id }
    validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/
  end

  def user_name
    user&.name || super
  end

  def user_email
    user&.email || super
  end

  private

  def self_subscription
    if event.user == user
      errors.add(:user_email, :self_subscription)
    end
  end

  def email_presence
    if User.find_by(email: user_email).present?
      errors.add(:user_email, :email_presence)
    end
  end
end
