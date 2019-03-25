FactoryBot.define do
  factory :user do
    name{ "a@a.com" }
    email{ "a@a.com" }
    password{ "a@a.com" }
  end

  factory :second_user, class: User do
    name{ "c@c.com" }
    email{ "c@c.com" }
    password{ "c@c.com" }
  end
end
