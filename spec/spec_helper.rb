require 'minitest/autorun'
require 'rack/test'
require 'rack-minitest/test'

require_relative '../lib/mails'

class Minitest::Test
  # include Rack::Test::Methods
  # include Rack::Minitest::Expectations
  # include Rack::Minitest::JSON
  include Dry::Monads::Maybe::Mixin
  include Dry::Monads::Result::Mixin

  # def setup
  #   super
  #   Mails::User::Repo.delete
  # end

  def teardown
    Mails::User::Repo.delete
  end
end
