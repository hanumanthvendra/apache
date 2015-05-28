require 'spec_helper'


system = Ohai::System.new

Ohai.plugin(:Apache) do
  provides "apache/modules"
end

puts system.all_plugins

require 'pry' ; binding.pry
