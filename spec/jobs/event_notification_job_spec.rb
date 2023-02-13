require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe EventNotificationJob, type: :job do
  let!(:user1) { FactoryBot.create(:user) }
  let!(:event) { FactoryBot.create(:event, user: user1) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:object) { FactoryBot.create(:subscription, event: event, user: user2) }

  before do
    object.save
    event.save
  end

  it "creates a job" do
    ActiveJob::Base.queue_adapter = :test
    expect { EventNotificationJob.perform_later(object) }.to have_enqueued_job.on_queue('default')
  end

  it "sends notification" do
    expect {
      perform_enqueued_jobs do
        EventNotificationJob.perform_later(object)
      end }.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it "is sent to right user" do
    perform_enqueued_jobs do
      EventNotificationJob.perform_later(object)
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq user1.email
  end
end
