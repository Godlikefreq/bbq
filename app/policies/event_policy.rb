class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.present?
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    user_is_owner?(record)
  end

  def show?
    pincode_passed?
  end

  private

  def user_is_owner?(record)
    user.present? && (record.user == user)
  end

  def pincode_passed?
    return true if record.pincode.blank?
    return true if user_is_owner?(record)

    if user.params[:pincode].present? && record.pincode_valid?(user.params[:pincode])
      user.params[:cookies].permanent["events_#{record.id}_pincode"] = user.params[:pincode]
    end

    record.pincode_valid?(user.params[:cookies].permanent["events_#{record.id}_pincode"])
  end
end
