require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ChairBnB
  class Application < Rails::Application
    config.paperclip_defaults = {
      :storage => :s3,
      :s3_credentials => {
        :bucket =>            ENV['S3_BUCKET'],
        :access_key_id =>     ENV['S3_ACCESS_ID'],
        :secret_access_key => ENV['S3_SECRET_ACCESS_KEY']
      }
    }
    
    
    config.generators do |g|
      g.test_framework :rspec,
        :fixtures => true,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => true,
        :request_specs => true
    end
  end
end
