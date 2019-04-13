require 'dry/monads/result'
require_relative './user'

module Mails
  class Router
    include Dry::Monads::Result::Mixin

    def call(verb, path)
      if get?(verb) && one_user?(path)
        Success(User::Show.new)
      elsif get?(verb) && all_users?(path)
        Success(User::List.new)
      elsif post?(verb) && all_users?(path)
        Success(User::Create.new)
      else
        Failure(:not_found)
      end
    end

    private

    def get?(verb)
      verb == 'GET'
    end

    def post?(verb)
      verb == 'POST'
    end

    def one_user?(path)
      path.match %r{^/user/.*}
    end

    def all_users?(path)
      path.match %r{^/users/?$}
    end
  end
end
