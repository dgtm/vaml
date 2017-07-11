require 'vault'
module Vaml
  module VaultConfig
    def self.configure!
      ::Vault.configure do |config|
        config.address = Vaml.configuration.host
        config.token = Vaml.configuration.token
        config.ssl_verify = false
        config.timeout = 30
        config.ssl_timeout  = 5
        config.open_timeout = 5
        config.read_timeout = 30
      end
    end
  end
end
