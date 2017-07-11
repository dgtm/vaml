module Vaml
  class Configuration
    attr_accessor :organization, :host, :token
    def initialize(options)
      @host = options[:host]
      @token = options[:token]
      @organization = options[:organization]
    end
  end
end
