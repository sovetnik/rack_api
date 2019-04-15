require_relative './lib/mails'

Rack::Server.start app: Mails::App.new
