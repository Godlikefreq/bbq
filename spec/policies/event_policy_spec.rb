require "rails_helper"

RSpec.describe EventPolicy do
  let(:cookies) { ActionDispatch::Cookies::CookieJar.new(nil) }
  let(:user) { UserContext.new(User.create, { pincode: "", cookies: cookies }) }

  subject { described_class }

  permissions :create? do
    it "lets user to create" do
      expect(subject).to permit(user, Event)
    end

    it "do not let visitor to create" do
      expect(subject).not_to permit(nil, Event)
    end
  end

  permissions :edit?, :update?, :destroy? do
    context "when user is owner" do
      let(:event) { Event.create(user: user.user) }

      it "allows user to edit, update and destroy" do
        expect(subject).to permit(user.user, event)
      end
    end

    context "when user is not owner" do
      let(:event) { Event.create }

      it "does not allow user to edit, update and destroy" do
        expect(subject).not_to permit(user, event)
      end
    end
  end

  permissions :show? do
    context "without pincode" do
      let(:event) { Event.create }

      it "shows event" do
        expect(subject).to permit(user.user, event)
      end
    end

    context "with pincode" do
      let(:event) { Event.create(pincode: "123") }

      context "user is owner" do
        let(:event) { Event.create(pincode: "123", user: user.user) }

        it "shows event" do
          expect(subject).to permit(user.user, event)
        end
      end

      context "visitor with incorrect pincode" do
        it "does not show event" do
          expect(subject).not_to permit(user, event)
        end
      end

      context "visitor with correct pincode" do
        before do
          user.params[:pincode] = "123"
          allow(user.params[:cookies]).to receive(:permanent).and_return({})
        end

        it "shows event" do
          expect(subject).to permit(user, event)
        end
      end

      context "visitor with cookies" do
        before { allow(user.params[:cookies]).to receive(:permanent).and_return({ "events_#{event.id}_pincode" => "123" }) }

        it "shows event" do
          expect(subject).to permit(user, event)
        end
      end
    end
  end
end
