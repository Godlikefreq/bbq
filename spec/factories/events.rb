FactoryBot.define do
  factory :event do
    association :user

    title { "Название_#{rand(999)}" }
    description { "Описание_#{rand(999)}" }
    address { "Город_#{rand(999)}" }
    datetime { Time.now }
  end
end
