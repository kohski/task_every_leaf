class ApplicationController < ActionController::Base
  before_action :basic
  Bundler.require(*Rails.groups)
  Dotenv::Railtie.load

  private
  def basic
    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_NAME'] && password == ENV['BASIC_PASSWORD']
    end
  end
end
