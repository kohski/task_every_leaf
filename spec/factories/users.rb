FactoryBot.define do
  factory :user do
    name { "test user" }
    email { "test@test.com" }
    password { "password" }
    password_confirmation { "password" }

    trait :without_name do
      name {nil}
    end

    trait :over_length_name do
      name { "a"*256 }
    end

    trait :without_email do
      email {nil}
    end

    trait :over_length_email do
      email { "a"*255+"@test.com" }
    end

    trait :without_email do
      email { nil }
    end

    trait :not_formatted_email do
      email { "aaaaaaaaaaaaaaaaaaaaaaaaa" }
    end

    trait :duplicate_email_1 do
      email { "duplicate@test.com" }
    end

    trait :duplicate_email_2 do
      email { "duplicate@test.com" }
    end

    trait :with_short_password do
      password { "test" }
    end
  end
end
