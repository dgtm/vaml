desc 'Add a secret to Vault'
namespace :vaml do
  task :add_secret, [:arg1, :arg2] do |t, args|
    key, value = ARGV[1], ARGV[2]
    unless key && value
      puts "Usage: VAULT_HOST=xxx VAULT_TOKEN=xxx rake vaml:add_secret /secret/development/xxx value"
      raise
    end
    Vaml.configure(host: ENV['VAULT_HOST'], token: ENV['VAULT_TOKEN'])
    Vaml::Github.auth(ENV['VAULT_TOKEN'])
    Vaml.write_string(key, value)
    puts "the rake task did something"
    exit
  end

  task :read_secret do
    Vaml.configure(host: ENV['VAULT_HOST'], token: ENV['VAULT_TOKEN'])
    Vaml::Github.auth(ENV['VAULT_TOKEN'])
    puts Vaml.read_string(ARGV[1])
    exit
  end
end
