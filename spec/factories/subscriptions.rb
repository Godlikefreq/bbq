FactoryBot.define do
  factory :subscription do
    association :user
    association :event
  end
end



