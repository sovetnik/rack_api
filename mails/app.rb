module Mails
  class App
    def self.call(_env)
      # new(env: env).response
      [200, {}, ['Hello world']]
    end

    attr_reader :env

    def initialize(env: {})
      @env = env
    end

    def response
      # route_action.call(env)
      route_action
    end

    def route_action
      case env['PATH_INFO']
      when /users/
        :users
      when /user/
        :user
      end
    end
  end
end
