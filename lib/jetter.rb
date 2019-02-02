require "jetter/railtie"

module Jetter

  class << self
    attr_accessor :configuration
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
