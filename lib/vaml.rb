require 'psych'
require 'yaml'
require 'vaml/config_handler'
require 'vaml/version'
require 'vaml/vault_config'
require 'vaml/configuration'
require 'vaml/github'
require 'vaml/railtie' if defined?(Rails)
require 'pry'

module Vaml

  class << self
    attr_accessor :configuration

    # @param [Hash] options {host: '0.0.0.0:8200', token: ENV["VTOKEN"], organization: ''}
    def configure(options)
      options[:host] ||= 'http://127.0.0.1:8200'
      options[:token] ||= ENV['VAULT_TOKEN']
      options[:ssl_verify] ||= false

      self.configuration ||= Configuration.new(options)
      yield configuration if block_given?

      # Configures Vault itself.
      Vaml::VaultConfig.configure!
      self
    end

    def write_string(key, value)
      write(key, {value: value})
    end

    def read_string(key)
      read(key).data[:value]
    end

    def from_yaml(yml)
      handler = Vaml::ConfigHandler.new
      parser = Psych::Parser.new(handler)
      parser.parse(yml)
      handler.root.to_ruby.first
    end

    def read(query)
      Vault.with_retries(Vault::HTTPConnectionError) do
        val = Vault.logical.read(query)
        raise "VamlError: No secret was stored for #{query}" unless val
        val
      end
    end


    def write(key, value)
      Vault.with_retries(Vault::HTTPConnectionError) do
        Vault.logical.write(key, value)
      end
    end

    def auth_with_github(token)
      Vaml::Github.auth(token)
    end

    #   policy = <<-EOH
    #     path "sys" {
    #       policy = "deny"
    #     }
    #   EOH
    #   Vault.sys.put_policy("dev", policy)
    def add_policy(policy_name, policy_definition)
      Vault.sys.put_policy(policy_name, policy_definition)
    end

    def list_policies
      Vault.sys.policies.map do |name|
        Vault.sys.policy(name)
      end
    end
  end
end
