module Vaml
  class Configuration
    attr_accessor :organization, :host, :token, :ssl_verify
    def initialize(options)
      @host = options[:host]
      @token = options[:token]
      @organization = options[:organization]
      @ssl_verify = options[:ssl_verify]
    end
  end
end
