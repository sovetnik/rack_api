require 'dry/monads/maybe'
require 'dry/monads/result'
require 'dry/monads/try'

module Mails
  module User
    class Base
      include Dry::Monads::Maybe::Mixin
      include Dry::Monads::Result::Mixin
      include Dry::Monads::Try::Mixin
    end
  end
end

require_relative './user/repo'
require_relative './user/schema'
require_relative './user/create'
require_relative './user/list'
require_relative './user/show'
