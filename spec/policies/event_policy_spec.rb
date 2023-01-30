require "rails_helper"

RSpec.describe EventPolicy do
  let(:user) { User.new }

  subject { described_class }

  context "when user is not an owner" do
    let(:event) { Event.create }

    permissions :create? do
      it { is_expected.to permit(user, Event) }
      it { is_expected.not_to permit(nil, Event) }
    end

    permissions :edit?, :update?, :destroy? do
      it { is_expected.not_to permit(user, event) }
    end

    permissions :show? do
      it { is_expected.to permit(user, Event) }
      it { is_expected.to permit(nil, Event) }
    end
  end

  context "when user is an owner" do
    let(:event) { Event.create(user: user) }

    permissions :edit?, :update?, :destroy? do
      it { is_expected.to permit(user, event) }
    end
  end
end