module Vaml
  class ConfigHandler < Psych::TreeBuilder
    def scalar value, anchor, tag, plain, quoted, style
      vault_regex = /vault:/
      translated = if value.match(vault_regex)
        query = value.gsub(vault_regex, '')
        Vaml.read_string(query)
      else
        value
      end
      super translated, anchor, tag, plain, quoted, style
    end
  end
end
