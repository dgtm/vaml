module Vaml
  module Github
    def self.enable_auth(org = Vaml.configuration.organization)
      puts "Enabling auth for #{org} ... "
      Vault.sys.enable_auth("github", "github")
      Vault.logical.write("auth/github/config", organization: org)
    end

    def self.grant_policy(team_name, policy_name)
      Vault.client.post("/v1/auth/github/map/teams/#{team_name}", policy_name)
      # Vault.logical.write("auth/github/map/teams/#{team_name}", policy_name)
    end

    def self.auth(token)
      puts "Authenticating to Github ... "
      Vault.auth.github(token)
    end
  end
end
