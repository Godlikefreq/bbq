require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe EventNotificationJob, type: :job do
  let!(:user1) { User.create(email: 'hi@hi.com') }
  let!(:event) { Event.create(user: user1) }
  let!(:user2) { User.create(email: 'bye@bye.com') }

  before do
    Subscription.create(user: user2, body: "Hello!")
  end




end
