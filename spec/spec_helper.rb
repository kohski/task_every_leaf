require 'factory_bot_rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    FactoryBot.reload
  end

  config.include FactoryBot::Syntax::Methods
end

def create_data_for_search_test
  task1 = FactoryBot.create(:task_searched,:name_a_status_0)
  task2 = FactoryBot.create(:task_searched,:name_a_status_1) 
  task3 = FactoryBot.create(:task_searched,:name_a_status_2)
  task4 = FactoryBot.create(:task_searched,:name_b_status_0) 
  task5 = FactoryBot.create(:task_searched,:name_b_status_1) 
  task6 = FactoryBot.create(:task_searched,:name_b_status_2) 
end