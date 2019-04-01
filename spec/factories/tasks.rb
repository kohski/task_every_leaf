FactoryBot.define do
  factory :task, class: 'task' do
    name { 'test task' }
    content { 'test task content' }

    trait :sequence do
      sequence(:name){|n| "test task name no.#{n}" }
      sequence(:content){|n| "test task content no.#{n}" }      
    end
  end
end
