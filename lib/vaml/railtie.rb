require 'rails'
module Vaml
  class Railtie < Rails::Railtie
    railtie_name :vaml

    rake_tasks do
      load "tasks/add_secret.rake"
    end
  end
end
