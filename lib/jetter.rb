require "jetter/railtie"

module Jetter

  class << self
    attr_accessor :configuration
  end

  def self.client(raw_token = {})
    Client.new({
      api_user: self.configuration.api_user,
      api_secret: self.configuration.api_secret
      api_merchant: self.configuration.api_merchant
    }, raw_token)
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
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