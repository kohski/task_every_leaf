FactoryBot.define do
  factory :task, class: 'task' do
    name { 'test task' }
    content { 'test task content' }

    trait :sequence do
      sequence(:name){|n| "test task name no.#{n}" }
      sequence(:content){|n| "test task content no.#{n}" }      
    end

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

    trait :sort_by_expired_at_previous do
      name { 'test name previous' }
      content { 'test content previous' } 
      expired_at { DateTime.now + 1 }
    end

    trait :sort_by_expired_at_following do
      name { 'test name following' }
      content { 'test content following' } 
      expired_at { DateTime.now + 2 }
    end

  end
end
