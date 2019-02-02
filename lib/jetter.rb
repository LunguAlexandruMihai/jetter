require "jetter/railtie"

module Jetter

  class << self
    attr_accessor :configuration
  
    def client(credentials = {}, raw_token = {})
      credentials = {
        api_user: self.configuration.api_user,
        api_secret: self.configuration.api_secret,
        api_merchant: self.configuration.api_merchant
      }
      Client.new(credentials, raw_token)
    end

    def configure
      self.configuration ||= Configuration.new
      yield(configuration)
    end
  end

  class Configuration
    attr_accessor :api_user, :api_secret, :api_merchant

    def initialize
      @api_user = 'default_option'
      @api_secret = 'default_option'
      @api_merchant = 'default_option'
    end
  end
end

require 'jetter/client'