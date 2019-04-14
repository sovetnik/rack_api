require 'dry/monads/result'
require_relative './user'

module Mails
  class Router
    include Dry::Monads::Result::Mixin

    def call(request)
      case request.env['PATH_INFO']
      when %r{^/user/.*}
        user_path(request)
      when %r{^/users/?$}
        users_path(request)
      else
        Failure(:not_found)
      end
    end

    private

    def user_path(request)
      return Success(User::Show.new) if request.get?

      Failure(:not_found)
    end

    def users_path(request)
      return Success(User::List.new) if request.get?
      return Success(User::Create.new) if request.post?

      Failure(:not_found)
    end
  end
end
