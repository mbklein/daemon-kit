begin
  require 'stomp'
rescue LoadError
  $stderr.puts "Missing stomp gem. Please run 'bundle install'."
  exit 1
end
