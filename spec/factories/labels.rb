FactoryBot.define do
  factory :label do
    name { "label name" }
    content { "label content" }

    trait :without_name do 
      name { nil }
    end

    trait :with_over_255_name do
      name { 'a' * 256 }
    end
  end
end
