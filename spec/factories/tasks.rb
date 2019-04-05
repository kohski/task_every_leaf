FactoryBot.define do
  factory :task, class: 'task' do
    name { 'test task' }
    content { 'test task content' }
    expired_at { DateTime.now + 1 }
    status { 0 }
    priority { 0 }
    association :user

    trait :no_name do
      name { '' }
      content { 'test content '}
    end

    trait :over_255_charactors_name do
      name { 'a'*256 }
      content { 'test content '}
    end

    trait :over_1000_charactors_content do
      name { 'test name' }
      content { 'a'* 1001 } 
    end

    trait :valid_name_with_no_content do
      name { 'test name' }
      content { '' } 
    end
  end
end
