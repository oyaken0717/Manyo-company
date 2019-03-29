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

  factory :admin_user, class: User do
    name { "ad@ad.com" }
    email { "ad@ad.com" }
    password { "ad@ad.com" }
    admin {"true"}
  end

  factory :admin_user2, class: User do
    name { "ad2@ad2.com" }
    email { "ad2@ad2.com" }
    password { "ad2@ad2.com" }
    admin {"true"}
  end
end
