require "jetter/railtie"

module Jetter

  def self.client(credentials = {}, raw_token = {})
    credentials = {
      api_user: configuration.api_user,
      api_secret: configuration.api_secret,
      api_merchant: configuration.api_merchant
    }
    Client.new(credentials, raw_token)
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class << self
    attr_accessor :configuration
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