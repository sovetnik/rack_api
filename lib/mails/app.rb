module Mails
  class App
    attr_reader :router

    def initialize(router: Mails::Router.new)
      @router = router
    end

    def call(env)
      request = Rack::Request.new(env)

      action = router.call(request)

      return [404, {}, [action.failure]] if action.failure?

      result = action.bind do |action|
        action.call(request)
      end

      return [422, {}, [{ error: result.failure }.to_json]] if result.failure?

      result.bind do |success|
        return [200, {}, [{ data: success }.to_json]]
      end
    end
  end
end
