# Vaml

Vaml is Vault with YAML, and a little sweet of Github. It helps you manage your app's secrets from your yml files.
It also provides support for Github Auth Integration, so you can easily control key access to developers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vaml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vaml

## Usage

### Configuration
```
Vaml.configure do |v|
  v.host = "http://127.0.0.1:8200"
  v.organization = 'xxx'
  v.token = ENV['VAULT_TOKEN']
end
```

or

`Vaml.configure(host: 'xxx', organization: 'xxx', token: 'xxx')`

### Reading and writing
```
Vaml.read(key)
Vaml.write(key, value)
```

### Policies
You can add and list Policies

* List policies

`Vaml.list_policies`

* Add policies

```
#   policy_definition = <<-EOH
#     path "sys" {
#       policy = "deny"
#     }
#   EOH

Vaml.add_policy(policy_name, policy_definition)
```
Internally all this does is the original call to Vault.

`Vault.sys.put_policy("dev", policy)`


## Github Integration

```
Vaml::Github.enable_auth(organization)
Vaml::Github.grant_policy(team_name, policy_name)
```

### YAML Integration

Given, you have an input yml that looks like:
```
development:
  aws:
    access_id: 'XXX'
staging:
  aws:
    access_id: vault:/secrets/staging/aws/access_id
production:
  aws:
    access_id: vault:/secrets/production/aws/access_id
```

`Vaml.from_yaml(File.read('input_yml.yml'))`

gives you back a ruby object that looks like:

```
```
Note that this does not actually write back to the file, and it is your job to use this result as you want.

The gem also provides a rake task that you can use to add secrets. As a developer, if you want to add a new secret:

* Use this syntax in you YML:
  `access_id: vault:/secrets/staging/aws/access_id`

* Then, add your secret with `rake vaml:add_secret`. You will need to set an `ENV['VAULT_TOKEN']` to run this command. If Github integration is activated, Go your Developer Settings > Personal Access Token and select the `admin:org` scope. You can now use this token with the command.

`VAULT_TOKEN=my_token rake vaml:add_secret /secrets/staging/aws/access_id AXXSAWEDFSF`

* After you configure vault, you can also add secrets from the rails console using the same token.

```
Vaml::Github.auth(my_token)
Vaml.write(key, value)
```

If you have been given proper access rights, you will be able to successfully write the secret.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/vaml.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
