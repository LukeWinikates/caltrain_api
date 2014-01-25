$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'vcr'
require 'webmock'
require 'caltrain_api'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  CaltrainApi::Client.configure do |api_config|
    api_config[:auth_token] = File.read(File.join(File.dirname(__FILE__), '.api_token'))
  end

  VCR.configure do |c|
    c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
    c.hook_into :webmock
    c.default_cassette_options = {
      :record => :new_episodes,
      :match_requests_on => [:method, VCR.request_matchers.uri_without_params(:token)]
    }
    c.after_http_request do |req|
      req.uri.gsub!(/&?token=[^&$]+/, '')
    end
    c.configure_rspec_metadata!
  end
end
