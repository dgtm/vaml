module Vaml
  module Github
    def self.enable_auth(org = Vaml.configuration.organization)
      puts "Enabling auth for #{org} ... "
      Vault.sys.enable_auth("github", "github") unless Vault.sys.auths[:github]
      Vault.logical.write("auth/github/config", organization: org)
    end

    def self.grant_policy(team_name, policy_name)
      puts "Granting policy for #{team_name} ... #{policy_name} "
      Vaml.write_string("auth/github/map/teams/#{team_name}", policy_name)
    end

    def self.auth(token)
      puts "Authenticating to Github ... "
      Vault.auth.github(token)
    end
  end
end
