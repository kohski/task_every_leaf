FactoryBot.define do
  factory :task, class: 'task' do
    name { 'test task' }
    content { 'test task content' }
    expired_at { DateTime.now + 1 }
    status { 0 }
    priority { 0 }

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
    end

    trait :sort_by_expired_at_following do
      name { 'test name following' }
      content { 'test content following' } 
      expired_at { DateTime.now + 2 }
    end

    trait :low_priority do
      name { 'low priority task' }
      priority { 0 }      
    end

    trait :middle_priority do
      name { 'middle priority task' }
      priority { 1 }      
    end

    trait :high_priority do
      name { 'high priority task' }
      priority { 2 }      
    end

  end

  factory :task_searched, class: 'task' do
    name { 'test task sort' }
    content { 'test task content sort' }
    expired_at { DateTime.now + 1 }
    status { 0 }

    trait :name_a_status_0 do
      name { 'a_name_1' }
      status { 0 }
    end

    trait :name_a_status_1 do
      name { 'a_name_2' }
      status { 1 }
    end

    trait :name_a_status_2 do
      name { 'a_name_3' }
      status { 2 }
    end

    trait :name_b_status_0 do
      name { 'b_name_1' }
      status { 0 }
    end

    trait :name_b_status_1 do
      name { 'b_name_2' }
      status { 1 }
    end

    trait :name_b_status_2 do
      name { 'b_name_3' }
      status { 2 }
    end
  end
end
